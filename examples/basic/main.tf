provider "spotinst" {
  token = "your-token"
  account = "your-account"
}
terraform {
  required_providers {
    spotinst = {
      source = "spotinst/spotinst"
    }
  }
}
## Create Ocean VNG on Spot.io ##
module "ocean-aws-k8s-vng" {
  source                                          =   "spotinst/ocean-aws-k8s-vng/spotinst"
  ocean_id                                        =   "o-123456"
  name                                            =   "test-vng"
  instance_types_filters_enable                   =   true
  instance_types_filters_categories               =   ["Accelerated_computing", "Compute_optimized"]
  instance_types_filters_disk_types               =   ["NVMe", "EBS"]
  instance_types_filters_exclude_families         =   ["t2","R4*"]
  instance_types_filters_exclude_metal            =   true
  instance_types_filters_hypervisor               =   ["nitro"]
  instance_types_filters_include_families         =   ["c5*", "g5"]
  instance_types_filters_is_ena_supported         =   true
  instance_types_filters_max_gpu                  =   4
  instance_types_filters_min_gpu                  =   0
  instance_types_filters_max_memory_gib           =   16
  instance_types_filters_max_network_performance  =   20
  instance_types_filters_max_vcpu                 =   16
  instance_types_filters_min_enis                 =   2
  instance_types_filters_min_memory_gib           =   8
  instance_types_filters_min_network_performance  =   2
  instance_types_filters_min_vcpu                 =   2
  instance_types_filters_root_device_types        =   ["ebs"]
  instance_types_filters_virtualization_types     =   ["hvm"]
  images                                          = [{image_id="ami-123456"},{image_id="ami-67890"}]
  utilize_commitments                             = true
  utilize_reserved_instances                      = false
  should_roll                                     = true
  batch_size_percentage                           = 50
  respect_pdb                                     = true
  instance_store_policy_type                      = "RAID0"
}
