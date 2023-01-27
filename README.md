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
}
```
~> You must configure the `spotinst_ocean_aws` resource. Ensure `spotinst_ocean_aws` resource (defined in `ocean-aws-k8s` module) is defined before this module as the `ocean_id` is needed. 

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.95 |

## Modules
* `ocean-aws-k8s` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/spotinst/ocean-aws-k8s/spotinst/latest)
* `ocean-controller` - Create and installs spot ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst/latest)
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