provider "spotinst" {
  token = "redacted"
  account = "redacted"
}

## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source = "../"

  cluster_name  = var.cluster_name
  ocean_id      = module.k8s-ocean.ocean_id

  # Name of VNG in Ocean
  name = "stateless"
  # Add Labels or taints
  labels = [{key="type",value="stateless"}]
  #taints = [{key="type",value="stateless",effect="NoSchedule"}]
  tags = {CreatedBy = "terraform"}
}

## Create additional Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_gpu" {
  source = "../"

  cluster_name  = var.cluster_name
  ocean_id      = module.k8s-ocean.ocean_id

  # Name of VNG in Ocean
  name = "gpu"

  # Add Labels or taints
  labels = [{key="type",value="gpu"}]
  taints = [{key="type",value="gpu",effect="NoSchedule"}]
  # Limit VNG to specific instance types
  #instance_types = ["g4dn.xlarge","g4dn.2xlarge"]

  # Change the spot %
  #spot_percentage = 50
}

## Outputs ##
output "virtual_node_group_gpu_id" {
  value = module.ocean_eks_launchspec_gpu.virtual_node_group_id
}
output "virtual_node_group_stateless_id" {
  value = module.ocean_eks_launchspec_stateless.virtual_node_group_id
}
