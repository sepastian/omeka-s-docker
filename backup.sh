#!/bin/bash

# backup script
#
# - create an SQL dump of the database
# - copy files form Omeka S (files/ modules/ themes/)
#
# output directory: ./backup/YYYYYMMDDTHHMMSS

set -euo pipefail

# source env from .env file
export $(grep -v '^#' .env | xargs)

base_dir="$(dirname $0)"
backup_dir="${base_dir}/backup/$(date +'%Y%m%dT%H%M%S')"
mkdir -p "${backup_dir}"

echo "creating backup in ${backup_dir}"

echo "backing up database"
docker compose exec mariadb mariadb-dump --all-databases -uroot -p"${MARIADB_ROOT_PASSWORD}" > "${backup_dir}/mariadb_dump.sql"

echo "copying file assets"
for d in files modules themes
do
    docker compose cp omeka-s:/var/www/html/"${d}" "${backup_dir}"
done

echo "done"
