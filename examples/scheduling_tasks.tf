## Create Ocean Virtual Node Group (launchspec) ##
module "ocean_eks_launchspec_stateless" {
  source  = "spotinst/ocean-aws-k8s-vng/spotinst"

  cluster_name        = "Example-EKS"
  ocean_id            = module.ocean-aws-k8s.ocean_id
  min_instance_count  = 1

  # Name of VNG in Ocean
  name = "stateless"

  # Add Labels or taints
  labels = [{key="type",value="stateless"}]
  taints = [{key="type",value="stateless",effect="NoSchedule"}]

  scheduling_task = [{
      is_enabled		= true
      cron_expression 	= "0 1 * * *"
      task_type 		= "manualHeadroomUpdate"
      num_of_units 		= 1
      cpu_per_unit 		= 200
      gpu_per_unit		= 0
      memory_per_unit	= 400
    },
    {
      is_enabled		= true
      cron_expression 	= "0 2 * * *"
      task_type 		= "manualHeadroomUpdate"
      num_of_units 		= 0
      cpu_per_unit 		= 0
      gpu_per_unit		= 0
      memory_per_unit	= 0
    }
  ]

  initial_nodes = 1
}