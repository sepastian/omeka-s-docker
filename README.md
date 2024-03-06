# Omeka S Docker

Docker image for Omeka S.

Ready-to-run docker compose file bundling Omeka S, Maria DB and Nginx.

## Usage

```shell
# Build Omeka S docker image.
docker compose build

# Generate random passwords in secrets/mariadb_password and secrets/mariadb_root_password.
# This can be done manually; in Linux, try:
tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo > secrets/mariadb_password
tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo > secrets/mariadb_root_password

# Ready!
docker compose up

# Navigate to localhost:8080 to finish installation.
```
