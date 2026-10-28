# Changelog

The version numbers of `omeka-s-docker` are following the upstream version numbers of Omeka S.

Changes internal to this repository only are denoted by lowercase letters appended to the Omeka S version number. 
For example, `4.1.1b` refers to a change in this repository, the Omeka S version is the same as in the `4.1.1` release.

## Unreleased

(empty)

## 4.2.1b - 2026-10-28

### Changed

* Fixing startup issue caused by php-fpm config
* Updating to php 8.5, which is supported since Omeka-S 4.2.1
* Updating documentation

The config files for Omeka-S and php-fpm are now baked into the image.
Thus, it is no longer required to mount the config files in `compose.yml`,
the corresponding volumes have been removed. If you still need to change 
configuration settings, mount the files, see `config.override.yml.sample`.

## 4.2.1 - 2026-10-23

### Changed

* Updating to Omeka S v4.2.1
* Updating PHP to v8.4.27 in response to CVE-2026-109618 and CVE-2026-109619.

## 4.0.4 - 2024-10-14

### Changed

* Adding and tagging previous version 4.0.4 of Omeka S

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
