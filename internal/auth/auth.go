package auth

import (
	"crypto/rand"
	"encoding/hex"
	"errors"
	"net/http"
	"strings"
	"time"

	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
	"golang.org/x/crypto/bcrypt"
)

type ValidUser struct {
	ID   uuid.UUID
	Role string
}

type CustomClaims struct {
	Role string `json:"role"`
	jwt.RegisteredClaims
}

type TokenType string

const (
	TokenTypeAccess TokenType = "medicant-access"
)

var ErrNoAuthHeaderIncluded = errors.New("no auth header included in request")

func HashPassword(password string) ([]byte, error) {
	return bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
}

func CheckPasswordHash(hashedPassword string, password string) error {
	return bcrypt.CompareHashAndPassword([]byte(hashedPassword), []byte(password))
}

func MakeRefreshToken() (string, error) {
	token := make([]byte, 32)
	_, err := rand.Read(token)

	if err != nil {
		return "", err
	}

	return hex.EncodeToString(token), nil
}

func GetBearerToken(headers http.Header) (string, error) {
	authHeader := headers.Get("Authorization")

	if authHeader == "" {
		return "", ErrNoAuthHeaderIncluded
	}

	splitAuth := strings.Split(authHeader, " ")

	if len(splitAuth) < 2 || splitAuth[0] != "Bearer" {
		return "", errors.New("malformed authorization header")
	}

	return splitAuth[1], nil
}

func MakeJWT(userID uuid.UUID, role string, tokenSecret string, expires time.Duration) (string, error) {
	signingKey := []byte(tokenSecret)

	claims := CustomClaims{
		role,
		jwt.RegisteredClaims{
			Issuer:    string(TokenTypeAccess),
			IssuedAt:  jwt.NewNumericDate(time.Now()),
			ExpiresAt: jwt.NewNumericDate(time.Now().Add(expires)),
			Subject:   userID.String(),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	return token.SignedString(signingKey)
}

func Validate(tokenString, tokenSecret string) (ValidUser, error) {
	claimsStruct := CustomClaims{}

	token, err := jwt.ParseWithClaims(tokenString, &claimsStruct, func(t *jwt.Token) (any, error) {
		return []byte(tokenSecret), nil
	})

	if err != nil {
		return ValidUser{}, err
	}

	userIDString, err := token.Claims.GetSubject()

	if err != nil {
		return ValidUser{}, err
	}

	issuer, err := token.Claims.GetIssuer()

	if err != nil {
		return ValidUser{}, err
	}

	if issuer != string(TokenTypeAccess) {
		return ValidUser{}, errors.New("invalid issuer")
	}

	userID, err := uuid.Parse(userIDString)

	if err != nil {
		return ValidUser{}, errors.New("error when parsing uuid string")
	}

	return ValidUser{ID: userID, Role: claimsStruct.Role}, nil
}
