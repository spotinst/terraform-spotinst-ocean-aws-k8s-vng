## Create Ocean Virtual Node Group (launchspec) ##
module "ocean-aws-k8s-vng_stateless" {
  source = "spotinst/ocean-aws-k8s-vng/spotinst"

  cluster_name  = "Example-EKS"
  ocean_id      = module.ocean-aws-k8s.ocean_id

  # Name of VNG in Ocean
  name = "stateless"

  # Add Labels or taints
  labels = [{key="type",value="worker"}]
  taints = [{key="type",value="worker",effect="NoSchedule"}]

  block_device_mappings = {
    device_name						= "/dev/xvda"
    delete_on_termination 			= true
    encrypted 						= true
    kms_key_id 						= "717e36d8-f059-454b-8634-123456789"
    snapshot_id 					= null
    iops                            = null
    volume_type 					= "gp2"
    volume_size						= 100
    throughput						= null
    no_device 						= null
  }
}