#!/bin/bash

if [ -f .env ]; then
    source .env
fi

cd migrations
goose turso $TURSO_DATABASE_URL up
