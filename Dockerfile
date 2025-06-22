FROM --platform=linux/amd64 debian:stable-slim

ADD medicant /usr/bin/medicant

CMD ["medicant"]
