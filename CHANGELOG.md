<a name="unreleased"></a>
## [Unreleased]



<a name="v0.16.0"></a>
## [v0.16.0] (March 21, 2025)

- Added `instance_store_policy` object to support Ephemeral storage ([#47](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/47))


<a name="v0.15.0"></a>
## [v0.15.0] (November 21, 2024)

- changelog update ([#46](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/46))
- added `reserved_enis` to support max pods configuration ([#45](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/45))


<a name="v0.14.0"></a>
## [v0.14.0] (October 23, 2024)

- Changelog 0.14.0 ([#44](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/44))
- Added support for `respect_pdb` field under `roll_config`. ([#43](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/43))


<a name="v0.13.0"></a>
## [v0.13.0] (September 18, 2024)

- Changelog v0.13.0 ([#42](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/42))
- Updated ocean controller v2 reference in README  ([#41](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/41))


<a name="v0.12.0"></a>
## [v0.12.0] (September 16, 2024)

- Changelog v0.12.0 ([#40](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/40))
- Added support for `utilize_commitments` and `utilize_reserved_instances` under strategy in spotinst_ocean_aws_launch_spec. ([#39](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/39))


<a name="v0.11.1"></a>
## [v0.11.1] (August 8, 2024)

- Changelog v0.11.1 ([#38](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/38))
- Updated default value to avoid creation failure ([#37](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/37))


<a name="v0.11.0"></a>
## [v0.11.0] (August 7, 2024)

- V0.11.0 Changelog ([#36](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/36))
- feat: added instance_metadata_options block & variables ([#16](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/16))
- added support for draining_timeout field ([#35](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/35))


<a name="v0.10.0"></a>
## [v0.10.0] (June 20, 2024)

- Changelog v0.10.0 ([#33](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/33))
- feat (ocean/aws): Added support for `preferred_od_types` ([#32](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/32))


<a name="v0.9.0"></a>
## [v0.9.0] (March 29, 2024)

- Correcting Repository URL in the changelog
- feat: added support for `ephemeral_storage_device_name`. ([#30](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/30))
- change-owner-request ([#29](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/29))


<a name="v0.8.0"></a>
## [v0.8.0] (January 2, 2024)

- changelog v0.8.0 ([#28](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/28))
- fixed the attributes of `block_device_mappings` object to accept null ([#27](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/27))


<a name="v0.7.0"></a>
## [v0.7.0] (November 21, 2023)

- Changelog v0.7.0 ([#26](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/26))
- added support for `images` object ([#25](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/25))


<a name="v0.6.0"></a>
## [v0.6.0] (November 11, 2023)

- changelog_0.6.0 ([#24](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/24))
- fix: added `instance_types_filters_enable` variable to handle `instance_types_filters` object ([#23](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/23))


<a name="v0.5.0"></a>
## [v0.5.0] (October 11, 2023)

- changelog v0.5.0 ([#19](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/19))
- Added support for `instance_types_filters`. ([#17](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/17))
- 🌒 work in progress Wed Oct 11 13:50:50 2023 ([#18](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/18))
- [src] removed common workflow
- [src] added common workflow


<a name="v0.4.3"></a>
## [v0.4.3] (January 26, 2023)

- docs(changelog): v0.4.3
- Remove the use of cluster_name
- fix typo in  "force_delete" varaible description ([#13](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/13))
- Update CHANGELOG.md
- support delete_node ([#12](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/12))


<a name="v0.4.2"></a>
## [v0.4.2] (December 5, 2022)

- Remove required tags to prevent duplication ([#11](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/11))
- V0.4.1 - Make tag name optional ([#9](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/9))


<a name="v0.4.0"></a>
## [v0.4.0] (October 5, 2022)

- Update CHANGELOG
- Allow mulitple block device mappings ([#7](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/7))

### 

and numerous whitespace changes.
* updated block_device_example to use list of objects


<a name="v0.3.0"></a>
## [v0.3.0] (July 16, 2022)

- Update changelog
- Merge pull request [#5](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/5) from spotinst/v0.2.1
- Merge branch 'main' into v0.2.1
- Add Update_policy
- Add scheduling_shutdown_hours and scheduling_tasks
- add auto headroom
- Remove AWS Version constraint
- Update changelog
- Update versions
- Update BDM and add example for block_device_mapping


<a name="v0.2.1"></a>
## [v0.2.1] (July 13, 2022)



<a name="v0.2.2"></a>
## [v0.2.2] (July 13, 2022)

- Merge pull request [#6](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/6) from open-store/remove_required_versions
- retain spotinst version
- remove required dependencies versions so that Ocean and AWS can be pinned elsewhere
- docs(changelog): v0.2.0


<a name="v0.2.0"></a>
## [v0.2.0] (March 24, 2022)

- fix changelog
- docs(changelog): v0.3.0
- [fix] elastic_ip_pool to  - remove errors when null and support multiple tags ([#4](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/4))
- Merge remote-tracking branch 'origin/main'
- Update CODEOWNERS
- Update CODEOWNERS
- Repository settings check
- Add files via upload
- docs(changelog): v0.1.0


<a name="v0.1.0"></a>
## v0.1.0 (December 21, 2021)

- initial commit ([#1](https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/issues/1))
- Initial commit


[Unreleased]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.16.0...HEAD
[v0.16.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.15.0...v0.16.0
[v0.15.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.14.0...v0.15.0
[v0.14.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.13.0...v0.14.0
[v0.13.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.12.0...v0.13.0
[v0.12.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.11.1...v0.12.0
[v0.11.1]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.11.0...v0.11.1
[v0.11.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.10.0...v0.11.0
[v0.10.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.9.0...v0.10.0
[v0.9.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.8.0...v0.9.0
[v0.8.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.7.0...v0.8.0
[v0.7.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.6.0...v0.7.0
[v0.6.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.5.0...v0.6.0
[v0.5.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.4.3...v0.5.0
[v0.4.3]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.4.2...v0.4.3
[v0.4.2]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.4.0...v0.4.2
[v0.4.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.2.1...v0.3.0
[v0.2.1]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.2.2...v0.2.1
[v0.2.2]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.2.0...v0.2.2
[v0.2.0]: https://github.com/spotinst/terraform-spotinst-ocean-aws-k8s-vng/compare/v0.1.0...v0.2.0
