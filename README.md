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

## Overrides

If present during `docker compose up`, a compose override file names `compose.override.yml` will be merged with `compose.yml`.

This can be used to override settings or specify additional attributes.

The sample file `compose.override.yml.sample` shows how to configure Traefik in a virtual hosting environment.
To get started, copy that file to `compose.override.yml` and (re)start Docker containers.

```shell
cp compose.override.yml.sample compose.override.yml
docker compose up
```

## Backup & Restore

> The Omeka S documentation does not contain information on how to backup and restore. Use the following information at your own risk.

### Backup

To create a backup,
  * create a database dump
  * make copies of these folders
    * `/var/www/html/files`
    * `/var/www/html/modules`
    * `/var/www/html/themes`

```shell
cd omeka-s-docker/
mkdir backup/
cd backup/

# Dump the database to a file;
# obtain the MariaDB root password from the .env file 
docker compose exec mariadb mariadb-dump --all-databases -uroot -p"7VDNpz4HusJO" > mariadb_dump.sql

# Copy required data
for d in files modules themes
do
  docker compose cp php-fpm:/var/www/html/"${d}" .
done
```

### Restore

The `backup/` folder now contains a complete backup.
It is recommended to create backups in regular intervals, for example through cron.
Individual backups should be compressed and rotated, for example using logrotate.

To restore the backup created above:

```shell
cd omeka-s-docker/backup/


# (Re)create containers
docker compose up -d

# Restore database backup;
# obtain MariaDB root password from .env
docker exec -i omeka-s-docker-hamm-mariadb-1 \
  sh -c 'exec mariadb -uroot -p"<secret>"' \
  < mariadb_dump.sql

# Copy backup data into docker volume
for d in files themes modules
do
  docker compose cp backup/"${d}" omeka-s:/var/www/html
done

# Update ownership of /var/www/html
docker compose exec --user root omeka-s chown -R www-data:www-data /var/www/html
```

### Purge

If there is an existing Omeka S installation with (running) containers and volumes,
it may interfere with the backup you are trying to restore.
The following snippet shows how to **completely delete** an existing instance.

<font color="#ff0000">CONTINUE AT YOUR OWN RISK!</font>

```shell
# WARNING
# THE FOLLOWING COMMANDS WILL DESTROY YOUR EXISTING OMEKA S INSTANCE!
# YOU HAVE BEEN WARNED!

cd omeka-s-docker/

# Prune existing containers
docker compose rm -sf

# List Docker volumes
docker volumes ls

# Delete container containing data
# (Your volume may have a slightly different name.)
docker volume rm omeka-s-docker-hamm_www_dir
```

Now restore the backup as described above, see [Restore](#restore).
