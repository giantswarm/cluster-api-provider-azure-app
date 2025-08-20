# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Removed

- Chart: More chores. ([#200](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/200))
  - Config: Remove default credentials.
  - Config: Remove Azure Service Operator credentials.
  - Config: Remove CAPZ Controller client ID.

## [3.0.1] - 2025-08-20

### Changed

- Chart: Update CAPZ to v1.16.5-gs-9535f270d. ([#201](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/201))

## [3.0.0] - 2025-08-13

### Added

- Chart: Add `azure.workload.identity/client-id` annotation to service accounts. ([#176](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/176))
- Chart: Add `azure.workload.identity/use: "true"` label to Azure Service Operator. ([#195](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/195))

### Changed

- Chart: Update CAPZ to v1.16.5. ([#188](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/188))
  - Values: Update image to v1.16.5-gs-0a602128d.
  - Chart: Update CRDs.
  - Chart: Update webhooks.
  - Chart: Update Azure Service Operator.
  - Chart: Update CAPZ Controller.
- Drop dummy `caBundle` field to support Kubernetes 1.31

### Removed

- Chart: Update CAPZ to v1.16.5. ([#188](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/188))
  - Config: Remove `patches/daemonsets/capz-nmi.yaml`.
  - Config: Remove `patches/services/azureserviceoperator-proxy-service.yaml`.
  - Hack: Remove `rbac.authorization.k8s.io_v1_clusterrole_capz-aad-pod-id-nmi-role.yaml`.
  - Hack: Remove `rbac.authorization.k8s.io_v1_clusterrolebinding_capz-aad-pod-id-nmi-binding.yaml`.

## [2.0.0] - 2025-05-28

### Added

- Chart: Some chores. ([#186](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/186))
  - Helpers: Add `cluster-api-provider-azure.fullname`.
  - Helpers: Add `cluster-api-provider-azure.crd-install.labels`.

### Changed

- Repository: Rework sync. ([#182](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/182))
  - Hack: Extract `fetch-manifest.sh`.
  - Hack: Rework `generate-kustomize-patches.sh` into `generate-webhook-patches.sh`.
  - Config: Move `ssh-sso-public-key-secret.yaml` to `bases/secrets/cluster-api-provider-azure-ssh-sso-pub-key.yaml`.
  - Config: Move `secret-bootstrap-credentials.yaml` to `bases/secrets/credential-default.yaml`.
  - Config: Transform `common-labels.yaml` into `labels`.
  - Config: Move `webhook-prefix.yaml` to `patches/mutatingwebhooks/zzz-prefix.yaml`.
  - Config: Rework `images`.
  - Config: Move `deployment-capz-args.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-affinity.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-environment.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-metrics-port.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-securitycontext.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-toleration.yaml` to `patches/deployments/capz-controller-manager.yaml`.
  - Config: Move `deployment-aso-securitycontext.yaml` to `patches/deployments/azureserviceoperator-controller-manager.yaml`.
  - Config: Move `deployment-aso-volume.yaml` to `patches/deployments/azureserviceoperator-controller-manager.yaml`.
  - Config: Split `webhook-certificate.yaml` into `patches/mutatingwebhooks/capz-mutating-webhook-configuration.yaml` & `patches/validatingwebhooks/capz-validating-webhook-configuration.yaml`.
  - Config: Split `webhook-certificate-aso.yaml` into `patches/mutatingwebhooks/azureserviceoperator-mutating-webhook-configuration.yaml` & `patches/validatingwebhooks/azureserviceoperator-validating-webhook-configuration.yaml`.
  - Config: Move `service-add-metrics-port.yaml` to `patches/services/capz-webhook-service.yaml`.
  - Config: Move `certificate.yaml` to `patches/certificates/capz-serving-cert.yaml`.
  - Config: Move `certificate-serviceoperator.yaml` to `patches/certificates/azureserviceoperator-serving-cert.yaml`.
  - Config: Move `delete-selfsigned-cert-issuer.yaml` to `patches/issuers/capz-selfsigned-issuer.yaml`.
  - Config: Move `delete-ns.yaml` to `patches/namespaces/capz-system.yaml`.
  - Config: Move `delete-nmi.yaml` to `patches/daemonsets/capz-nmi.yaml`.
  - Config: Move `secret-aso-controller-settings.yaml` to `patches/secrets/aso-controller-settings.yaml`.
  - Config: Move `deployment-aso-remove-kube-proxy.yaml` to `patches/deployments/azureserviceoperator-controller-manager.yaml`.
  - Config: Move `delete_aadpodidentity_crds.yaml` to `patches/crds/unapproved.yaml`.
  - Config: Move `crd_cainjection.yaml` to `patches/crds/capz.yaml`.
  - Config: Move `aso_crd_cainjection.yaml` to `patches/crds/azureserviceoperator.yaml`.
  - Config: Move `crd_webhook.yaml` to `patches/crds/capz.yaml`.
  - Config: Move `crd_clusterctl_labels.yaml` to `patches/crds/capz.yaml`.
  - Config: Move `mutating-webhook-watchfilter.yaml` to `patches/mutatingwebhooks/capz-mutating-webhook-configuration-object-selector.yaml`.
  - Config: Move `validating-webhook-watchfilter.yaml` to `patches/validatingwebhooks/capz-validating-webhook-configuration-object-selector.yaml`.
  - Config: Move `config/helm/copy` to `helm/cluster-api-provider-azure/templates/static`.
  - Config: Extract inline patch into `patches/services/azureserviceoperator.yaml`.
  - Config: Extract inline patch into `patches/services/azureserviceoperator-proxy-service.yaml`.
  - Config: Extract inline patch into `patches/crds/all.yaml`.
  - Hack: Rework `move-generated-crds.sh` into `move-crds.sh`.
  - Hack: Rename `generate-crd-version-patches.sh` into `generate-crd-patches.sh`.
  - Hack: Rework `generate-helm-conditions.sh` into `wrap-in-conditions.sh`.
  - Hack: Rework `cleanup-helm-templates.sh` into `remove-quotes.sh`.
- Chart: Some chores. ([#186](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/186))
  - Chart: Rework `Chart.yaml`.
  - Values: Update `values.schema.json`.
  - Values: Rework `image`.
  - Values: Rework `aso`.
  - Values: Rework `project`.
  - Values: Rework `provider`.
  - Values: Rework `ciliumNetworkPolicy`.
  - Values: Rework `crdInstall`.
  - Values: Rework `workloadCluster`.
  - Values: Rework `controller`.
  - Values: Rework `verticalPodAutoscaler`.
  - Values: Rework `serviceMonitor`.
  - Values: Rework `global.podSecurityStandards`.
  - Helpers: Rework `name` into `cluster-api-provider-azure.name`.
  - Helpers: Rework `chart` into `cluster-api-provider-azure.chart`.
  - Helpers: Rework `labels.common` into `cluster-api-provider-azure.labels`.
  - Helpers: Rework `labels.selector` into `cluster-api-provider-azure.selectorLabels`.
  - Helpers: Rework `capz.crdInstall` into `cluster-api-provider-azure.crd-install.fullname`.
  - Helpers: Rework `capz.CRDInstallAnnotations` into `cluster-api-provider-azure.crd-install.annotations`.
  - Helpers: Rework `capz.selectorLabels` into `cluster-api-provider-azure.crd-install.selectorLabels`.
  - Helpers: Rework `capz.webhookObjectSelector` into `cluster-api-provider-azure.objectSelector`.
  - Helpers: Rework `deployment.args.watchfiltervalue` into `cluster-api-provider-azure.watchFilter`.
  - CRD Install: Rework `crd-np.yaml` into `networkpolicy.yaml`.
  - CRD Install: Rework `crd-configmap.yaml` into `configmap.yaml`.
  - CRD Install: Rework `crd-serviceaccount.yaml` into `serviceaccount.yaml`.
  - CRD Install: Extract ClusterRole into `clusterrole.yaml`.
  - CRD Install: Extract ClusterRoleBinding into `clusterrolebinding.yaml`.
  - CRD Install: Rework `crd-job.yaml` into `job.yaml`.
  - Static: Rework `vpa.yaml` into `capz-controller-manager-verticalpodautoscaler.yaml`.
  - Static: Rework `service-monitor.yaml` into `capz-controller-manager-servicemonitor.yaml`.
  - Static: Rework `rbac.authorization.k8s.io_v1_clusterrolebinding_azureserviceoperator-crd-manager-rolebinding.yaml` into `azureserviceoperator-crd-manager-clusterrolebinding.yaml`.
  - Static: Rework `rbac.authorization.k8s.io_v1_clusterrole_azureserviceoperator-crd-manager-role.yaml` into `azureserviceoperator-crd-manager-clusterrole.yaml`.
  - Static: Rework `networking.k8s.io_v1_networkpolicy_azureserviceoperator-controller-manager.yaml` into `azureserviceoperator-controller-manager-networkpolicy.yaml`.
  - Static: Rework `networking.k8s.io_v1_networkpolicy_capz-controller-manager.yaml` into `capz-controller-manager-networkpolicy.yaml`.
  - Static: Rework `cilium.io_v2_ciliumnetworkpolicy_azure-service-operator-controller-manager.yaml` into `azureserviceoperator-controller-manager-ciliumnetworkpolicy.yaml`.
  - Static: Rework `cilium.io_v2_ciliumnetworkpolicy_capz-controller-manager.yaml` into `capz-controller-manager-ciliumnetworkpolicy.yaml`.

### Removed

- Repository: Rework sync. ([#182](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/182))
  - Config: Remove obsolete `daemonset-nmi-args.yaml`.
- Chart: Some chores. ([#186](https://github.com/giantswarm/cluster-api-provider-azure-app/pull/186))
  - CI: Remove values.
  - Values: Remove `name`.
  - Helpers: Remove `_resource.tpl`.
  - Helpers: Remove `labels.provider`.
  - Helpers: Remove `capz.CRDInstallConfigmapNameGenerate`.
  - Helpers: Remove `capz.CRDInstallSelector`.
  - CRD Install: Remove `crd-ciliumnetworkpolicy.yaml`.
  - CRD Install: Remove `crd-psp.yaml`.

## [1.12.4-gs2] - 2024-07-17

### Changed

- Remove kube-rbac-proxy from azure-service-operator.
- Use image of azure-service-operator from `gsoci.azurecr.io`.

## [1.12.4-gs1] - 2024-07-10

### Changed

- Bump CAPZ version to `1.12.4`.

## [1.9.0-alpha.9] - 2024-06-26

### Added

- Add ServiceMonitor for monitoring.
- Add missing `CiliumNetworkPolicy` CRs.

### Changed

- Add node affinity to prefer scheduling on `control-plane` nodes.
- Add toleration for `node.cluster.x-k8s.io/uninitialized` taint.
- Remove toleration for old `node-role.kubernetes.io/master` taint.
- Update `app.giantswarm.io` labels prefixes as `application.giantswarm.io`.

## [1.9.0-alpha.8] - 2024-01-18

### Added

- Add `global.podSecurityStandards.enforced` value for PSS migration.

## [1.9.0-alpha.7] - 2023-08-17

### Fixed

- Update CAPZ version to fix private links NAT IP configuration.
- Fix issues in crd-install reported by kyverno.

## [1.9.0-alpha.6] - 2023-07-21

### Fixed

- Add required values for pss policies.
- Update CAPZ version to newer alpha version (from our fork) with private endpoints deletion fixed.

## [1.9.0-alpha.5] - 2023-06-19

- Update CAPZ version to newer alpha version (from our fork) with private endpoints deletion fixed.

### Added

- Add new toleration for the `node-role.kubernetes.io/control-plane` taint.

## [1.9.0-alpha.4] - 2023-04-27

- Update CAPZ version to fork build with private links support.

## [1.9.0-gs.alpha.2] - 2023-04-06

### Changes

- Update CAPZ version to v1.9.0-gs.alpha.5 built from Giant Swarm fork (based on upstream CAPZ v1.8.2).

## [1.9.0-gs.alpha.1] - 2023-03-20

### Changes

- Update upstream CAPZ to use version from the fork to get gateway transit feature.
- Revert the creationTimestamp null since it breaks installing the CRDs in a brand new cluster.

## [1.8.1] - 2023-03-09

### Changes

- Remove the AKS FeatureFlag since is not supported anymore

## [1.8.0] - 2023-03-09

### Changes


- Update upstream cluster-api-provider-azure version from v1.6.1 to v1.8.0 (see highlighted changes below)


### Highlighted upstream changes that can be relevant for vintage workload clusters

- `v1.6.2` - Nothing relevant
- `v1.6.3` - Nothing relevant
- `v1.7.0` - [Add webhook for AzureClusterIdentity resource](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2862)
- `v1.7.1` - Nothing relevant
- `v1.7.2` - Nothing relevant
- `v1.8.0` - Nothing relevant

### Highlighted upstream changes that can be relevant for CAPZ workload clusters

- `v1.6.2` - Nothing relevant
- `v1.6.3` - [Fixes not routable issue of service type of load balancer when AzureClusterName and ClusterName are different](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/3154)
- `v1.7.0` - [Replace deprecated ADAL authentication with MSAL](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2748) - no impact other than users relying on certificate authentication
- `v1.7.0` - [Add "VMIdentitiesReadyCondition" AzureMachine condition](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2743) - no impact
- `v1.7.0` - [Adds additional fields for AzureMachine, AzureMachineTemplate, and AzureMachinePool to configure multiple NetworkInterfaces](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2411)
- `v1.7.0` - [Default Ubuntu to 22.04 for new k8s versions](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2807) - No impact on clusters-azure app 0.0.14+ which switched to flatcar
- `v1.7.0` - [Add webhook for AzureClusterIdentity resource](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2862)
- `v1.7.0` - [VMSS Flex support for MachinePools ](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2813)
- `v1.7.0` - [Cleanup remote peerings when resource group is deleted](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2767)
- `v1.7.1` - Nothing relevant
- `v1.7.2` - [Fix idleTimeoutInMinutes for Control Plane Outbound LB to use the right LB spec](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/3140)
- `v1.8.0` - [Graduate AKS APIs from experimental ](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2959)
- `v1.8.0` - [Add support for private endpoints](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/3044)
- `v1.8.0` - [Allow configurable scope and role assignment for SystemAssigned identities ](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2965)
- `v1.8.0` - [Allow configurable scope and role assignment for SystemAssigned identities ](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2965)
- `v1.8.0` - [AzureMachinePool Controller will no watch KubeadmConfig to ensure AzureMachinePool Bootstrap data is updated on the VMSS](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/3134)

### Upstream release notes

- [v1.6.2](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.6.2)
- [v1.6.3](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.6.3)
- [v1.7.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.7.0)
- [v1.7.1](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.7.1)
- [v1.7.2](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.7.2)
- [v1.8.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.8.0)

## [1.7.0] - 2023-01-24

### Changes

- Update upstream cluster-api-provider-azure version from v1.5.4 to v1.6.0 (see highlighted changes below)
- add `provider.flavor` to values with default to _vintage_ , needed for all conditional rendering between capi and vintage
- In CAPI keep the `capz-controller` secret
- In CAPI keep the `leader election` resources and flags
- In CAPI keep the `NMI` RBAC resources to make it work with the `azure-ad-pod-identity-app`
- Add `crd labels` patch to make `clusterctl move` work for CAPZ CRDs
- Make the `watch-filter` conditional, disable it in CAPI
- Make verbosity of the controller configurable
- Update upstream cluster-api-provider-azure version from v1.6.0 to v1.6.1 (see highlighted changes below)

### Highlighted upstream changes that can be relevant for vintage workload clusters

- `v1.6.0` [Add evictionPolicy field for spot VMs](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2689). Vintage workload clusters support node pools that are using spot instances with Azure's default `Deallocate` eviction policy. Changing eviction policy is not possible for vintage workload clusters.
- `v1.6.1` - Nothing

### Highlighted upstream changes

(with specified upstream cluster-api-provider-azure versions)

- `v1.6.0` [Add support for custom vm extensions](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2631)
- `v1.6.0` [Add support for adding Virtual Network Service Endpoints to subnets created/managed by CAPZ](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2635)
- `v1.6.1` [Fix Machinepool reconciliation when resourceGroupName has capital letters in it](https://github.com/kubernetes-sigs/cluster-api-provider-azure/pull/2894)

### Upstream release notes

- [v1.6.0](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.6.0)
- [v1.6.1](https://github.com/kubernetes-sigs/cluster-api-provider-azure/releases/tag/v1.6.1)

## [1.6.0] - 2022-12-20

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

[Unreleased]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v3.0.1...HEAD
[3.0.1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v3.0.0...v3.0.1
[3.0.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.12.4-gs2...v2.0.0
[1.12.4-gs2]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.12.4-gs1...v1.12.4-gs2
[1.12.4-gs1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.9...v1.12.4-gs1
[1.9.0-alpha.9]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.8...v1.9.0-alpha.9
[1.9.0-alpha.8]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.7...v1.9.0-alpha.8
[1.9.0-alpha.7]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.6...v1.9.0-alpha.7
[1.9.0-alpha.6]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.5...v1.9.0-alpha.6
[1.9.0-alpha.5]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-alpha.4...v1.9.0-alpha.5
[1.9.0-alpha.4]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-gs.alpha.2...v1.9.0-alpha.4
[1.9.0-gs.alpha.1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.9.0-gs.alpha.1...v1.9.0-gs.alpha.2
[1.9.0-gs.alpha.1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.8.1...v1.9.0-gs.alpha.1
[1.8.1]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.8.0...v1.8.1
[1.8.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.6.0...v1.7.0
[1.6.0]: https://github.com/giantswarm/cluster-api-provider-azure-app/compare/v1.5.0...v1.6.0
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
