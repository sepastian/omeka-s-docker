# Omeka S Docker

Docker image for Omeka S.

Ready-to-run docker compose file bundling Omeka S, Maria DB and Nginx.

## Usage

```shell
# Build Omeka S docker image.
docker compose build

# Maria DB requires passwords, for regular/root users.
# Write two random string into secrets/mariadb_password and
# secrets/mariadb_root_password, respectively.
# Alternatively, in Linux, generate random passwords with:
tr -dc A-Za-z0-9 </dev/urandom | head -c 12 > secrets/mariadb_password
tr -dc A-Za-z0-9 </dev/urandom | head -c 12 > secrets/mariadb_root_password

# Ready!
docker compose up
```

Navigate to localhost:8080 to finish installation.
