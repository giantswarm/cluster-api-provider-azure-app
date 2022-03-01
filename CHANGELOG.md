# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Use `delete` patches to delete manifests rather than `rm -rf`.
- Delete manifests before generating them.
- Use `kustomize` to render SSH SSO secret.
- Remove leader election manifests.

### Added

- Add verify CI step to verify manifests have been generated and comitted.

## [1.0.0] - 2022-01-27

### Changed

- Helm manifests are generated from upstream assets attached to a release.

## [0.5.3-gs1] - 2021-10-05

### Changed

- Bumped `cluster-api-azure-controller` to version `v0.5.3` (vanilla upstream version).

## [0.5.2] - 2021-09-29

### Changed

- Bumped `cluster-api-azure-controller` to version `v0.5.0` (vanilla upstream version).
- Removed dedicated container for the webhook.
- Added `ssh-sso-public-key` secret.

### Added

- Added config annotation in chart.

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

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.5.3-gs1...v1.0.0
[0.5.3-gs1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.5.2...v0.5.3-gs1
[0.5.2]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.4.12-gsalpha3...v0.5.2
[0.4.12-gsalpha3]: https://github.com/giantswarm/cluster-api-provider-azure-app/releases/tag/v0.4.12-gsalpha3
