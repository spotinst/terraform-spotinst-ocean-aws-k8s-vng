## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  # Name of VNG in Ocean
  name = "stateless"
  ocean_id     = module.ocean-aws-k8s.ocean_id

  # Add Labels or taints
  labels = [{ key = "type", value = "worker" }]
  taints = [{ key = "type", value = "worker", effect = "NoSchedule" }]

  block_device_mappings       = [{
    device_name               = "/dev/xvdb"
    encrypted                 = false
    volume_type               = "gp3"
  }
  ]
  dynamic_volume_size         = {
    base_size                 = 50
    resource                  = "CPU"
    size_per_resource_unit    = 20
  }

  ephemeral_storage_device_name = "/dev/xvdb"
}
