# Omeka S Docker

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

# Copy the sample .env.sample file to .env.
cp .env.sample .env

# Set MARIADB_ROOT_PASSWORD and MARIADB_PASSWORD in .env;
# leave other values untouched.
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

# Visit http://localhost:8080 to install Omeka S.
```

Navigate to http://localhost:8080 to setup Omeka S and finish the installation.
