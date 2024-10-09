# Changelog

The version numbers of `omeka-s-docker` are following the upstream version numbers of Omeka S.

Changes internal to this repository only are denoted by lowercase letters appended to the Omeka S version number. 
For example, `4.1.1b` refers to a change in this repository, the Omeka S version is the same as in the `4.1.1` release.

## Unreleased

## 4.1.1b - 2024-10-09

### Changed

* Updating name of image in `compose.yml` to GHCR image name
* Renaming service `php-fpm` to `omeka-s`

## 4.1.1 - 2024-10-09

### Added

* Omeka S v4.1.1
* `.env` files instead of Docker secrets for database credentials
* `OMEKA_DB_CONNECTION_URL` instead of `config/database.ini`; see https://github.com/omeka/omeka-s/pull/1789

### Changed

* Removed docker secrets
