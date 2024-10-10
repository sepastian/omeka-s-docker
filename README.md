# 🏛 Omeka S Docker

Docker image for Omeka S.

Ready-to-run docker compose file bundling Omeka S, Maria DB and Nginx.

## Prerequisites

Install either Docker Engine (Linux only) or Docker Desktop (all platforms).

## Usage

Running the Omeka S Docker image requires:

  * clone this repository or download the `compose.yml` file,
  * set pull or build the Omeka S docker image,
  * configure database credentials
  * start containers

```shell
# Clone this repository,
# change directory.
git clone git@github.com:sepastian/omeka-s-docker.git
cd omeka-s-docker/

# Create an .env file from .env.sample,
# setting random values for MARIADB_ROOT_PASSWORD and MARIADB_PASSWORD.
sed \
  -e "s|<mariadb_password>|$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)|" \
  -e "s|<mariadb_root_password>|$(tr -dc A-Za-z0-9 </dev/urandom | head -c 12)|" \
  .env.sample > .env

# Either pull the Omeka S image from GHCR...
docker compose pull
# ... or, build the Omeka S docker image locally.
docker compose build

# Start containers.
docker compose up
```

Navigate to http://localhost:8080 to setup Omeka S and finish the installation.

# 🐋 Docker

If present during `docker compose up`, a compose override file names `compose.override.yml` will be merged with `compose.yml`.

This can be used to override settings or specify additional attributes.

The sample file `compose.override.yml.sample` shows how to configure Traefik in a virtual hosting environment.
To get started, copy that file to `compose.override.yml` and (re)start Docker containers.

```shell
cp compose.override.yml.sample compose.override.yml
docker compose up
```
