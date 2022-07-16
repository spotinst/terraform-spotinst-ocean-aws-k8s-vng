### Required Ocean VNG (Launch Spec) Configurations
variable "ocean_id" {
  type        = string
  description = "Ocean ID"
}
variable "cluster_name" {
  type        = string
  description = "Name of Cluster"
}
variable "name" {
  type        = string
  description = "Name for nodegroup (VNG)"
}
###################

## Optional VNG Configurations
variable "user_data" {
  type        = string
  default     = null
}
variable "worker_instance_profile_arn" {
  type        = string
  default     = null
  description = "Instance Profile ARN to assign to worker nodes. Should have the WorkerNode policy"
}
variable "security_groups" {
  type        = list(string)
  default     = null
  description = "List of security groups"
}
variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "List of subnets"
}
variable "ami_id" {
  type        = string
  default     = null
  description = "ami id"
}
variable "max_instance_count" {
  type        = number
  default     = null
  description = "(Optional) Set a maximum number of instances per Virtual Node Group. Can be null. If set, value must be greater than or equal to 0."
}
variable "min_instance_count" {
  type        = number
  default     = null
  description = "(Optional) Set a minimum number of instances per Virtual Node Group. Can be null. If set, value must be greater than or equal to 0."
}
variable "instance_types" {
  type        = list(string)
  default     = null
  description = "Specific instance types permitted by this VNG. For example, [\"m5.large\",\"m5.xlarge\"]"
}
variable "root_volume_size" {
  type        = number
  default     = 30
  description = "Size of root volume"
}
variable "associate_public_ip_address" {
  type        = bool
  default     = null
  description = "Configure public IP address allocation."
}
variable "restrict_scale_down" {
  type        = bool
  default     = null
  description = "When set to True, nodes will be treated as if all pods running have the restrict-scale-down label. Therefore, Ocean will not scale nodes down unless empty."
}
variable "spot_percentage" {
  type        = number
  default     = 100
  description = "Percentage of VNG that will run on EC2 Spot instances and remaining will run on-demand"
}
variable "labels" {
  type = list(object({
    key = string
    value = string
  }))
  default = null
  description = "NodeLabels / NodeSelectors"
}
variable "taints" {
  type = list(object({
    key = string
    value = string
    effect = string
  }))
  default = null
  description = "taints / toleration"
}
variable "tags" {
  type = map(string)
  default = null
  description = "Tags to be added to resources"
}
###################

## Block Device Mappings ##
variable "block_device_mappings" {
  type 								= object({
    device_name						= string
    delete_on_termination 			= bool
    encrypted 						= bool
    kms_key_id 						= string
    snapshot_id 					= string
    volume_type 					= string
    iops							= number
    volume_size						= number
    throughput						= number
    no_device 						= string
  })
  default 							= null
  description 						= "Block Device Mapping Object"
}
variable "dynamic_volume_size" {
  type 					  			= object({
    base_size						= number
    resource 						= string
    size_per_resource_unit			= number
  })
  default 							= null
  description 						= "dynamic_volume_size Object"
}
##################

variable "auto_headroom_percentage" {
  type    = number
  default = null
  description = "Number between 0-200 to control the headroom % of the specific Virtual Node Group. Effective when cluster.autoScaler.headroom.automatic.is_enabled = true is set on the Ocean cluster."
}

## Headroom ##
variable "cpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "memory_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the amount of memory (MiB) to allocate for each headroom unit."
}
variable "gpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of GPUS to allocate for each headroom unit."
}
variable "num_of_units" {
  type        = number
  default     = 0
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU, memory and GPU."
}
##################

## Create Actions ##
variable "initial_nodes" {
  type        = number
  default     = null
  description = "When set to an integer greater than 0, a corresponding amount of nodes will be launched from the created virtual node group."
}
##################

## preferred_spot_types ##
variable "preferred_spot_types" {
  type        = list(string)
  default     = null
  description = "A list of instance types. Takes the preferred types into consideration while maintaining a variety of machine types running for optimized distribution."
}
###################

## elastic_ip_pool ##
variable "elastic_ip_pool_tag_selector" {
  type        = map(string)
  default     = null
  description = "Elastic IP tag key. The Virtual Node Group will consider all Elastic IPs tagged with this tag as a part of the Elastic IP pool to use."
}
variable "force_delete" {
  type        = bool
  default     = false
  description = "When set to true, delete even if it is the last Virtual Node Group (also, the default Virtual Node Group must be configured with useAsTemlateOnly = true). Should be set at creation or update, but will be used only at deletion."
}
###################