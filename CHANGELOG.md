# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.12-gsalpha3] - 2021-07-14

### Added

- Push app to azure app collection.
- Route alerts to celestial.

### Changed

- Bumped `cluster-api-azure-controller` to version `v0.4.12-gsalpha3`.

### Removed

- Remove kube-rbac-proxy for the metrics endpoint.

### Fixed

- Fixed label selector for webhook and manager services.

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.4.12-gsalpha3...HEAD
[0.4.12-gsalpha3]: https://github.com/giantswarm/cluster-api-provider-azure-app/releases/tag/v0.4.12-gsalpha3
