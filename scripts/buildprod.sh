#!/bin/bash

CGO_ENABLED=1 GOOS=linux go build -o /usr/bin/medicant
