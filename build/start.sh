#!/usr/bin/env bash

set -e

PATH=$PATH:/usr/local/flyway

# Poll for database
until PGPASSWORD=$DATABASE_PASSWORD psql \
  -h $DATABASE_IP \
  -p $DATABASE_PORT \
  -U $DATABASE_USERNAME \
  -d 'postgres' \
  -w --list; do
    echo "[drunken-lizard-database] waiting for the database to come online"
    sleep 5
done

# create database, ignore failure in case it already exists
set +e
PGPASSWORD=$DATABASE_PASSWORD psql \
  -h $DATABASE_IP \
  -p $DATABASE_PORT \
  -U $DATABASE_USERNAME \
  -d 'postgres' \
  -w -c "create database ${DATABASE_NAME}"
set -e

exec "flyway" "$@"
