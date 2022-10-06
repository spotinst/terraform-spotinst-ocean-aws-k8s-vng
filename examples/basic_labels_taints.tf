## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  cluster_name = "Example-EKS"
  ocean_id     = module.ocean-aws-k8s.ocean_id

  # Name of VNG in Ocean
  name = "stateless"

  # Add Labels or taints
  labels = [{ key = "type", value = "worker" }]
  taints = [{ key = "type", value = "worker", effect = "NoSchedule" }]
}