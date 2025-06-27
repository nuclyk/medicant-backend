FROM golang:1.24

WORKDIR /app

# Create volume to store database file
RUN mkdir -p /app/db
VOLUME [ "/app/db" ]

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=1 GOOS=linux go build -o /app/medicant

EXPOSE 8080

CMD ["/app/medicant"]

