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

  # Spot.io Credentials
  spotinst_token              = "redacted"
  spotinst_account            = "redacted"

  cluster_name = "cluster_name"
  ocean_id = module.ocean-aws-k8s.ocean_id

  name = "stateless" # Name of VNG in Ocean
  #ami_id = "" # Can change the AMI

  labels = [{key="type",value="stateless"}]
  #taints = [{key="type",value="stateless",effect="NoSchedule"}]

  tags = {CreatedBy = "terraform"} #Addition Tags
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_gpu" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"
  # Spot.io Credentials
  spotinst_token              = "redacted"
  spotinst_account            = "redacted"

  cluster_name = "cluster_name"
  ocean_id = module.ocean-aws-k8s.ocean_id

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
  cluster_identifier = "cluster_name"
}