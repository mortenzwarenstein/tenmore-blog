#!/bin/bash
CONTAINER_NAME="database"

if [ "$( docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME )" == "running" ]; then
    mkdir -p ./migration/$CONTAINER_NAME
    docker exec -i $CONTAINER_NAME  /bin/bash -c "PGPASSWORD=directus pg_dump --username directus directus" > ./migration/$CONTAINER_NAME/dump-$(date +%s).sql
fi