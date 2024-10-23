# Spot Ocean k8s Virtual Node Group Terraform Module

Spotinst Terraform Module to integrate existing k8s node groups with Ocean launchspec/Virtual Node group (VNG)


## Usage
Note: This module will automatically import any tags defined in the AWS provider `default_tags`
```hcl
provider "spotinst" {
  token   = "redacted"
  account = "redacted"
}

module "ocean-aws-k8s" {
  ...
}

## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  name = "stateless" # Name of VNG in Ocean
  ocean_id = module.ocean-aws-k8s.ocean_id
  
  #ami_id = "" # Can change the AMI
  labels = [{key="type",value="stateless"}]
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_gpu" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  name = "gpu"  # Name of VNG in Ocean
  ocean_id = module.ocean-aws-k8s.ocean_id
  
  labels = [{key="type",value="gpu"}]
  taints = [{key="type",value="gpu",effect="NoSchedule"}]
  
  #instance_types = ["g4dn.xlarge","g4dn.2xlarge"] # Limit VNG to specific instance types
  spot_percentage = 50 # Change the spot %
  draining_timeout = 300 
}

## Create Ocean Virtual Node Group (launchSpec) with instance_type_filters ##
module "ocean-aws-k8s-vng" {
  source  = "spotinst/ocean-aws-k8s-vng/spotinst"
  ocean_id = module.ocean-aws-k8s.ocean_id
  name = "test-vng"
  instance_types_filters_enable                   =   true
  instance_types_filters_categories               =   ["Accelerated_computing", "Compute_optimized"]
  instance_types_filters_disk_types               =   ["NVMe", "EBS"]
  instance_types_filters_exclude_families         =   ["t2","R4*"]
  instance_types_filters_exclude_metal            =   true
  instance_types_filters_hypervisor               =   ["nitro"]
  instance_types_filters_include_families         =   ["c5*", "g5"]
  instance_types_filters_is_ena_supported         =   true
  instance_types_filters_max_gpu                  =   4
  instance_types_filters_min_gpu                  =   0
  instance_types_filters_max_memory_gib           =   16
  instance_types_filters_max_network_performance  =   20
  instance_types_filters_max_vcpu                 =   16
  instance_types_filters_min_enis                 =   2
  instance_types_filters_min_memory_gib           =   8
  instance_types_filters_min_network_performance  =   2
  instance_types_filters_min_vcpu                 =   2
  instance_types_filters_root_device_types        =   ["ebs"]
  instance_types_filters_virtualization_types     =   ["hvm"]
  images                                          =   [{image_id="ami-123456"},{image_id="ami-67890"}]
  block_device_mappings                           =   [{
    device_name                                   =   "/dev/xvda"
    encrypted                                     =   false
    volume_type                                   =   "gp3"
  }]
  dynamic_volume_size                             =   {
    base_size                                     =   50
    resource                                      =   "CPU"
    size_per_resource_unit                        =   20
  }
  ephemeral_storage_device_name                   =   "/dev/xvdb"
  preferred_spot_types                            =   ["m4.xlarge", "c3.large"]
  preferred_od_types                              =   ["t3.medium", "c4.large"]

}
```
~> You must configure the `spotinst_ocean_aws` resource. Ensure `spotinst_ocean_aws` resource (defined in `ocean-aws-k8s` module) is defined before this module as the `ocean_id` is needed. 

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.95 |

## Modules
* `ocean-aws-k8s` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/spotinst/ocean-aws-k8s/spotinst/latest)
* `ocean-controller` - Create and installs spot ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/kubernetes-controller/ocean)
* `ocean-aws-k8s-vng` - (Optional) Add custom virtual node groups [Doc](https://registry.terraform.io/modules/spotinst/ocean-aws-k8s-vng/spotinst/latest)

## Documentation

If you're new to [Spot](https://spot.io/) and want to get started, please checkout our [Getting Started](https://docs.spot.io/connect-your-cloud-provider/) guide, available on the [Spot Documentation](https://docs.spot.io/) website.

## Getting Help

We use GitHub issues for tracking bugs and feature requests. Please use these community resources for getting help:

- Ask a question on [Stack Overflow](https://stackoverflow.com/) and tag it with [terraform-spotinst](https://stackoverflow.com/questions/tagged/terraform-spotinst/).
- Join our [Spot](https://spot.io/) community on [Slack](http://slack.spot.io/).
- Open an issue.

## Community

- [Slack](http://slack.spot.io/)
- [Twitter](https://twitter.com/spot_hq/)

## Contributing

Please see the [contribution guidelines](CONTRIBUTING.md).

## Resources

| Name | Type |
|------|------|
| [ocean-aws-k8s-vng](https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/ocean_aws) | resource |

## Inputs

| Name                                                                                                                           | Description                                                                                                                                                                                                                                                                                                                                               | Type                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Default | Required |
|--------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|:--------:|
| <a name="input_ocean_id"></a> [ocean\_id](#input\_ocean\_id)  | The Ocean cluster identifier. Required for Launch Spec creation.                                                                                                                                                                                                                                                                                          | `string`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | `null`  | yes |
| <a name="input_name"></a> [name](#input\_name)  | Set launch specification name. | `string` | `null`  | no |
| <a name="input_instance_types_filters_enable"></a> [instance\_types\_filters\_enable](#input\_instance\_types\_filters\_enable) | 'instance_types_filters_enable' to be set to true to have instance_types_filters configured in the virtual node group. | `boolean`  | `null`  | no |
| <a name="input_instance_types_filters"></a> [instance\_types\_filters](#input\_instance\_types\_filters)                       | The instance types that match with all filters compose the Virtual Node Group's instanceTypes parameter. The architectures that come from the Virtual Node Group's images will be taken into account when using this parameter. Cannot be configured together with Virtual Node Group's instanceTypes and with the Cluster's whitelist/blacklist/filters. | <pre>object({<br>    categories                = list(string)<br>    disk_types                = list(string)<br>    exclude_families          = list(string)<br>    exclude_metal             = bool<br>    hypervisor                = list(string)<br>    include_families          = list(string)<br>    is_ena_supported          = bool<br>    max_gpu                   = number<br>    min_gpu                   = number<br>    max_memory_gib            = number<br>    max_network_performance   = number<br>    max_vcpu                  = number<br>    min_enis                  = number<br>    min_memory_gib            = number<br>    min_network_performance   = number<br>    min_vcpu                  = number<br>    root_device_types         = list(string)<br>    virtualization_types      = list(string)<br>  })</pre> | `null`  | no |
| <a name="input_images"></a> [images](#input\_images) | You can configure VNG with either the imageId or images objects, but not both simultaneously. <br> For each architecture type (amd64, arm64) only one AMI is allowed.<br>  Valid values: null, or an array with at least one element.  | <pre>list(object({<br>    image_id                = string <br>  }))</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `null`  | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings)  | block\_device\_mapping object | <pre>list(object({<br>  device_name             = string<br>  delete_on_termination   = bool<br>  encrypted               = bool<br>  kms_key_id              = string<br>  snapshot_id             = string<br>  volume_type             = string<br>  iops                    = number<br>  volume_size             = number<br>  throughput              = number<br>  }))</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `[]`    | no |
| <a name="input_dynamic_volume_size"></a> [dynamic\_volume\_size](#input\_dynamic\_volume\_size) | dynamic\_volume\_size object  | <pre>object({<br>  base_size              = number<br>  size_per_resource_unit = number<br>  resource               = string<br> })</pre>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | `null`  | no |
| <a name="input_ephemeral_storage_device_name"></a> [ephemeral\_storage\_device\_name](#input\_ephemeral\_storage\_device\_name) | ephemeral\_storage\_device\_name  | `string`| `null`  | no |
| <a name="input_draining_timeout"></a> [draining\_timeout](#input\_draining\_timeout)                                                                   | The configurable amount of time that Ocean will wait for the draining process to complete before terminating an instance. If you have not defined a draining timeout, the default of 300 seconds will be used.                                                                                                                                                                                                                                                                                                                                                             | `number`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `300`   | no |
| <a name="input_spot_percentage"></a> [spot\_percentage](#input\_spot\_percentage)                                                                      | The desired percentage of the Spot instances out of all running instances for this VNG. Only available when the field is not set in the cluster directly (cluster.strategy.spotPercentage).                                                                                                                                                                                                                                                                                      | `number`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `100`   | no |
| <a name="input_utilize_commitments"></a> [utilize\_commitments](#input\_utilize\_commitments)                                                          | When set as ‘true’, if savings plans commitments have available capacity, Ocean will utilize them alongside RIs (if exist) to maximize cost efficiency. If the value is set as 'null', it will automatically be inherited from the cluster level.                                                                                                                                                                                                                                                                      | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `false`      | no |
| <a name="input_utilize_reserved_instances"></a> [utilize\_reserved\_instances](#input\_utilize\_reserved\_instances)                                   | When set as ‘true’, if reserved instances exist, Ocean will utilize them before launching spot instances. If the value is set as 'null', it will automatically be inherited from the cluster level.                                                                                                                                                                                                                                                                                                                          | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `true`       | no |
| <a name="input_respect_pdb"></a> [respect\_pdb](#input\_respect\_pdb)                                                                                  | Default: false. During the roll, if the parameter is set to True we honor PDB during the instance replacement.                                                                                                                                                                                                                                                                                         | `bool`                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `null`       | no |
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_node_group_id"></a> [virtual\_node\_group\_id](#output\_virtual\_node\_group\_id) | The virtual node group ID |
<!-- END_TF_DOCS -->
