# build stage
FROM golang:1.24.4-bookworm AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=1 GOOS=linux go build -o /app/medicant

EXPOSE 8080

CMD ["/app/medicant"]

