# terraform-spotinst-k8s-ocean-launchspec

Spotinst Terraform Module to integrate existing k8s node groups with Ocean launchspec/Virtual Node group (VNG)


## Usage
Note: This module will automatically import any tags defined in the AWS provider `default_tags`
```hcl
provider "spotinst" {
  token   = "redacted"
  account = "redacted"
}

module "k8s-ocean" {
  ...
}

## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source = "stevenfeltner/k8s-ocean-launchspec/spotinst"

  # Spot.io Credentials
  spotinst_token              = "redacted"
  spotinst_account            = "redacted"

  cluster_name = local.cluster_name
  ocean_id = module.k8s-ocean.ocean_id
  
  name = "stateless" # Name of VNG in Ocean
  #ami_id = "" # Can change the AMI

  labels = [{key="type",value="stateless"}]
  #taints = [{key="type",value="stateless",effect="NoSchedule"}]
  
  tags = {CreatedBy = "terraform"} #Addition Tags
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_gpu" {
  source = "stevenfeltner/k8s-ocean-launchspec/spotinst"
  # Spot.io Credentials
  spotinst_token              = "redacted"
  spotinst_account            = "redacted"

  cluster_name = local.cluster_name
  ocean_id = module.k8s-ocean.ocean_id
  
  name = "gpu"  # Name of VNG in Ocean
  #ami_id = "" # Can chang  # Add Labels or taints
  
  labels = [{key="type",value="gpu"}]
  taints = [{key="type",value="gpu",effect="NoSchedule"}]
  
  #instance_types = ["g4dn.xlarge","g4dn.2xlarge"] # Limit VNG to specific instance types
  spot_percentage = 50 # Change the spot %
}

module "ocean-controller" {
  source = "spotinst/ocean-controller/spotinst"

  # Credentials.
  spotinst_token   = "redacted"
  spotinst_account = "redacted"

  # Configuration.
  cluster_identifier = var.cluster_name
}
```
~> You must configure the `spotinst_ocean_aws` resource. Ensure `spotinst_ocean_aws` resource (defined in `k8s-ocean` module) is defined before this module as the `ocean_id` is needed. 

## Providers

| Name | Version |
|------|---------|
| spotinst/spotinst | >= 1.60.0 |

## Modules
* `k8s-ocean` - Creates Ocean Cluster [Doc](https://registry.terraform.io/modules/stevenfeltner/k8s-ocean/spotinst/latest)
* `ocean-controller` - Create and installs spot ocean controller pod [Doc](https://registry.terraform.io/modules/spotinst/ocean-controller/spotinst/latest)
* `k8s-ocean-launchspec` - (Optional) Add custom virtual node groups [Doc](https://registry.terraform.io/modules/stevenfeltner/k8s-ocean-launchspec/spotinst/latest)

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