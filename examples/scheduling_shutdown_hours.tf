## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  # Name of VNG in Ocean
  name = "stateless"
  ocean_id           = module.ocean-aws-k8s.ocean_id

  # Add Labels or taints
  labels = [{ key = "type", value = "stateless" }]
  taints = [{ key = "type", value = "stateless", effect = "NoSchedule" }]

  scheduling_shutdown_hours = {
    time_windows = ["Tue:01:00-Tue:07:00",
      "Wed:01:00-Wed:07:00",
      "Thu:01:00-Thu:07:00",
      "Fri:01:00-Fri:07:00",
      "Sat:01:00-Sat:07:00",
    "Sun:01:00-Mon:07:00"]
    is_enabled = false
  }
}