## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  # Name of VNG in Ocean
  name = "stateless"
  ocean_id     = module.ocean-aws-k8s.ocean_id

  # Add Labels or taints
  labels = [{ key = "type", value = "worker" }]
  taints = [{ key = "type", value = "worker", effect = "NoSchedule" }]

  startup_taints = [
 {
   key    = "example-key1"
   value  = "example-value1"
   effect = "NoExecute"
 },
 {
   key    = "example-key2"
   value  = "example-value2"
   effect = "NoSchedule"
 }]
}