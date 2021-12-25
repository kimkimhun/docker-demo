#!/usr/bin/env bash

[ ! -d "mongo_data" ] && echo "Create directory mongo_data." && mkdir -p mongo_data
[ ! -d "pg_data" ] && echo "Create directory pg_data." && mkdir -p pg_data

docker-compose up -d kong-database

DB_NAME=$(docker ps -a --filter "name=kong-database" --format "{{.Names}}")
DB_STATUS=$(docker ps -a --filter "name=kong-database" --format "{{.Status}}" | cut -f 2 -d '(' | cut -f 1 -d ')')

echo "$DB_NAME status $DB_STATUS"

while [ "$DB_STATUS" != "healthy" ]
do
	sleep 5
	DB_STATUS=$(docker ps -a --filter "name=kong-database" --format "{{.Status}}" | cut -f 2 -d '(' | cut -f 1 -d ')')
	echo "$DB_NAME status $DB_STATUS"
done

docker-compose up -d migrations

docker-compose up -d 
