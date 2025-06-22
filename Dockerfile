FROM --platform=linux/arm64 debian:stable-slim

RUN apt-get update && apt-get install -y ca-certificates

ADD medicant /usr/bin/medicant

CMD ["medicant"]
