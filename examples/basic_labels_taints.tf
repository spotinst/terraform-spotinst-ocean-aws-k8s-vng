## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  # Name of VNG in Ocean
  name = "stateless"
  ocean_id     = module.ocean-aws-k8s.ocean_id

  # Add Labels or taints
  labels = [{ key = "type", value = "worker" }]
  taints = [{ key = "type", value = "worker", effect = "NoSchedule" }]
}