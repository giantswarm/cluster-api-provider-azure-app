# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changes

- Update upstream cluster-api-provider-azure version from v1.4.5 to v1.5.4 (see highlighted changes below)

### Highlighted upstream changes that can be relevant for vintage workload clusters

- N/A

### Highlighted upstream changes

(with specified upstream cluster-api-provider-azure versions)

- `v1.5.3` `controller-gen.kubebuilder.io/version` bump from v0.8.0 to v0.9.2. This caused removal of `Status` field and addition of `x-kubernetes-map-type` in CRDs. 

### Upstream release notes

- [v1.5.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.5.0)
- [v1.5.1](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.5.1)
- [v1.5.2](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.5.2)
- [v1.5.3](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.5.3)
- [v1.5.4](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.5.4)

## [1.5.0] - 2022-12-20

### Changes

- Update upstream cluster-api-provider-azure version from v1.3.2 to v1.4.5 (see highlighted changes below)
- Update docker-kubectl image version to v1.25.4.

### Highlighted upstream changes that can be relevant for vintage workload clusters

- N/A

### Highlighted upstream changes

(with specified upstream cluster-api-provider-azure versions)

- `v1.4.0` [Add support for Ultra Disks as Persistent Volumes](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2421)
- `v1.4.0` [Add support for user-assigned identity as AzureClusterIdentity](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2371)
- `v1.4.0` [Add ComputeGallery field and add community galleries support](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2277)
- `v1.4.3` [Add `node-role.kubernetes.io/control-plane` toleration to CAPZ manager deployment](https://github.com/kubernetes-sigs/cluster-api-provider-azure/issues/2640) implemented in [this PR](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2644)

### Upstream release notes

- [v1.4.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.0)
- [v1.4.1](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.1)
- [v1.4.2](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.2)
- [v1.4.3](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.3)
- [v1.4.4](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.4)
- [v1.4.5](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.4.5)

## [1.4.0] - 2022-12-19

### Changed

- Update upstream cluster-api-provider-azure version from v1.2.1 to v1.3.2 (see highlighted changes below)
- [CAPZ v1.3.0] [Add support for Service Principal with Certificate auth using AAD pod identity](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2258). This looks like a breaking change in theory, since `AzureClusterIdentity` `UserAssignedMSI` type is removed, but in practice it is not, because UserAssignedMSI never worked, see [this comment for more details](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2258/files#r859891486). In any case Giant Swarm workload clusters are not be affected, because all of them are using `ServicePrincipal` type.

### cluster-api-provider-azure upstream release notes
- [v1.3.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.3.0)
- [v1.3.1](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.3.1)
- [v1.3.2](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.3.2)

## [1.3.0] - 2022-12-16

### Changed

- Set CRD kubebuilder version in helm template.
- Update upstream cluster-api-provider-azure version from v1.1.3 to v1.2.1 (see highlights bellow).
- Generate values.schema.json.

## [1.2.0] - 2022-12-08

### Changed

- `PodSecurityPolicy` are removed on newer k8s versions, so only apply it in the `crd-install` job if object is registered in the k8s API.
- Update upstream cluster-api-provider-azure version from v1.0.1 to v1.1.3 (see highlights bellow).
- [CAPZ v1.1.3] Add new AzureClusterIdentity type - `ManualServicePrincipal`.
- [CAPZ v1.1.3] Add namespace listing permission to `ClusterRole` `capz-manager-role`.

### Added

- Restart azure-operator after ensuring CRDs because sometimes reconciliation stops.

## [1.1.0] - 2022-03-21

### Added

- Add VerticalPodAutoscaler CR.

## [1.0.1] - 2022-03-18

### Fixed

- Fix SSO Public key rendering so it comes from the `config` repo.

### Changed

- Use `delete` patches to delete manifests rather than `rm -rf`.
- Delete manifests before generating them.
- Use `kustomize` to render SSH SSO secret.
- Remove leader election manifests.

### Added

- Add verify CI step to verify manifests have been generated and committed.
- Installing CRDs via crd-install job.

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

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.5.0...HEAD
[1.5.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.5.3-gs1...v1.0.0
[0.5.3-gs1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.5.2...v0.5.3-gs1
[0.5.2]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v0.4.12-gsalpha3...v0.5.2
[0.4.12-gsalpha3]: https://github.com/giantswarm/cluster-api-provider-azure-app/releases/tag/v0.4.12-gsalpha3
