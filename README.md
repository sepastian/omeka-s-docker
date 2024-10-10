# Omeka S 🏢 ✕ 🐳 Docker

Docker image for Omeka S.

Ready-to-run docker compose file bundling Omeka S, Maria DB and Nginx.

## Prerequisites

Install either Docker Engine (Linux only) or Docker Desktop (all platforms).

## Quick Start

```shell
# Clone this repo
git clone git@github.com:sepastian/omeka-s-docker.git

# Change directory
cd omeka-s-docker/

# Generate MariaDB passwords *)
sed \
  -e "s|<mariadb_password>|$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)|" \
  -e "s|<mariadb_root_password>|$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)|" \
  .env.sample > .env

# Launch
docker compose up
```

Navigate to http://localhost:8080 to setup Omeka S and finish the installation.

_*) If you prefer, create the `.env` file manually, see `.env.sample` for an example. Passwords are required during backup and restore._

# 🐳 Docker

If present during `docker compose up`, a compose override file names `compose.override.yml` will be merged with `compose.yml`.

This can be used to override settings or specify additional attributes.

The sample file `compose.override.yml.sample` shows how to configure Traefik in a virtual hosting environment.
To get started, copy that file to `compose.override.yml` and (re)start Docker containers.

```shell
cp compose.override.yml.sample compose.override.yml
docker compose up
```

## Backup

## Restore

```shell
# Prune existing containers
docker compose rm -sf

# (Re)create containers
docker compose up -d

# Restore database backup;
# obtain MariaDB root password from .env
docker exec -i omeka-s-docker-hamm-mariadb-1 \
  sh -c 'exec mariadb -uroot -p"<secret>"' \
  < backup/mariadb_dump.sql

# Copy backup data into docker volume
for d in files themes modules
do
  docker compose cp backup/"${d}" omeka-s:/var/www/html
done

# Update ownership of /var/www/html
docker compose exec --user root omeka-s chown -R www-data:www-data /var/www/html
```
