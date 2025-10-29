### Required Ocean VNG (Launch Spec) Configurations
variable "ocean_id" {
  type        = string
  description = "Ocean ID"
}
variable "name" {
  type        = string
  description = "Name for nodegroup (VNG)"
}
###################

## Optional VNG Configurations
variable "user_data" {
  type    = string
  default = null
}
variable "image_id" {
  type        = string
  default     = null
  description = "ID of the image used to launch the instances."
}
variable "iam_instance_profile" {
  type        = string
  default     = null
  description = "The ARN or name of an IAM instance profile to associate with launched instances"
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
variable "instance_types" {
  type        = list(string)
  default     = null
  description = "Specific instance types permitted by this VNG. For example, [\"m5.large\",\"m5.xlarge\"]"
}
variable "preferred_spot_types" {
  type        = list(string)
  default     = null
  description = "A list of instance types. Takes the preferred types into consideration while maintaining a variety of machine types running for optimized distribution."
}
variable "preferred_od_types" {
  type        = list(string)
  default     = null
  description = "A list of instance types. Takes the preferred types into consideration while maintaining a variety of machine types running for optimized distribution."
}
variable "root_volume_size" {
  type        = number
  default     = 30
  description = "Size of root volume"
}
variable "tags" {
  type        = map(string)
  default     = null
  description = "(Optional) Tags by default will be inherited from the ocean_aws resource. If set this will overwrite all tags and not add additional tags to those already configured."
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

## instance_metadata_options ##
# Ocean instance metadata options object for IMDSv2

variable "http_tokens" {
  type        = string
  default     = "optional"
  description = "Determines if a signed token is required or not. Valid values: 'optional' or 'required'."

  validation {
    condition     = contains(["optional", "required"], var.http_tokens)
    error_message = "Valid values: 'optional' or 'required'."
  }
}

variable "http_put_response_hop_limit" {
  type        = number
  default     = 1
  description = "An integer from 1 through 64. The desired HTTP PUT response hop limit for instance metadata requests. The larger the number, the further the instance metadata requests can travel."

  validation {
    condition     = var.http_put_response_hop_limit >= 1 && var.http_put_response_hop_limit <= 64
    error_message = "Valid values: integer value between 1 and 64."
  }
}
###################

variable "labels" {
  type = list(object({
    key   = string
    value = string
  }))
  default     = null
  description = "NodeLabels / NodeSelectors"
}
variable "taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default     = null
  description = "taints / toleration"
}

## elastic_ip_pool ##
variable "elastic_ip_pool_tag_selector" {
  type        = map(string)
  default     = null
  description = "Elastic IP tag key. The Virtual Node Group will consider all Elastic IPs tagged with this tag as a part of the Elastic IP pool to use."
}
###################

## Block Device Mappings ##
variable "block_device_mappings" {
  description = "Block Device Mapping Object"
  type        = list(any)
  default     = []
}
variable "dynamic_volume_size" {
  type = object({
    base_size              = number
    resource               = string
    size_per_resource_unit = number
  })
  default     = null
  description = "dynamic_volume_size Object"
}
##################

## autoscale_headrooms_automatic ##
variable "auto_headroom_percentage" {
  type        = number
  default     = null
  description = "Number between 0-200 to control the headroom % of the specific Virtual Node Group. Effective when cluster.autoScaler.headroom.automatic.is_enabled = true is set on the Ocean cluster."
}
##################

## autoscale_headrooms ##
variable "num_of_units" {
  type        = number
  default     = 0
  description = "The number of units to retain as headroom, where each unit has the defined headroom CPU, memory and GPU."
}

## autoscale_down ##
variable "max_scale_down_percentage" {
  type        = number
  default     = null
  description = "Would represent the maximum % to scale-down. Number between 1-100."
}

## aggressive_scale_down
variable "is_aggressive_scale_down_enabled" {
  type        = bool
  default     = false
  description = "When set to 'true', the Aggressive Scale Down feature is enabled"
}
##################

variable "cpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of CPUs to allocate for each headroom unit. CPUs are denoted in millicores, where 1000 millicores = 1 vCPU."
}
variable "gpu_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the number of GPUS to allocate for each headroom unit."
}
variable "memory_per_unit" {
  type        = number
  default     = null
  description = "Optionally configure the amount of memory (MiB) to allocate for each headroom unit."
}
##################

## resource_limits ##
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
##################

## strategy ##
variable "spot_percentage" {
  type        = number
  default     = 100
  description = "Percentage of VNG that will run on EC2 Spot instances and remaining will run on-demand"
}

variable "draining_timeout" {
  type        = number
  default     = 300
  description = "The configurable amount of time that Ocean will wait for the draining process to complete before terminating an instance."
}

variable "utilize_commitments" {
  type        = bool
  default     = false
  description = "When set as ‘true’, if savings plans commitments have available capacity, Ocean will utilize them alongside RIs (if exist) to maximize cost efficiency. If the value is set as 'null', it will automatically be inherited from the cluster level."
}

variable "utilize_reserved_instances" {
  type        = bool
  default     = true
  description = "When set as ‘true’, if reserved instances exist, Ocean will utilize them before launching spot instances. If the value is set as 'null', it will automatically be inherited from the cluster level."
}

variable "availability_vs_cost" {
  type        = string
  default     = "balanced"
  description = "Set this value to control the approach that Ocean takes while launching nodes. Valid values: `costOriented`, `balanced`, `cheapest`."
}

## create_options ##
variable "initial_nodes" {
  type        = number
  default     = null
  description = "When set to an integer greater than 0, a corresponding amount of nodes will be launched from the created virtual node group."
}
##################

## delete_options ##
variable "force_delete" {
  type        = bool
  default     = false
  description = "When set to true, delete even if it is the last Virtual Node Group (also, the default Virtual Node Group must be configured with useAsTemplateOnly = true). Should be set at creation or update, but will be used only at deletion."
}
variable "delete_nodes" {
  type        = bool
  default     = false
  description = "When set to true, all instances belonging to the deleted launch specification will be drained, detached, and terminated."
}
##################

## scheduling_shutdown_hours.tf ##
variable "scheduling_task" {
  type = list(object({
    is_enabled      = bool
    cron_expression = string
    task_type       = string
    num_of_units    = number
    cpu_per_unit    = number
    gpu_per_unit    = number
    memory_per_unit = number
  }))
  default     = null
  description = "scheduling_task Object"
}
##################

## scheduling_tasks.tf ##
variable "scheduling_shutdown_hours" {
  type = object({
    time_windows = list(string)
    is_enabled   = bool
  })
  default     = null
  description = "scheduling_shutdown_hours Object"
}
##################

## update_policy ##
variable "should_roll" {
  type        = bool
  default     = false
  description = "Enables the roll."
}
variable "batch_size_percentage" {
  default     = "20"
  type        = number
  description = "Sets the percentage of the instances to deploy in each batch."
}
variable "respect_pdb" {
  type        = bool
  default     = null
  description = "Default: false. During the roll, if the parameter is set to true we honor PDB during the instance replacement."
}
##################

## instance_types_filters ##
variable "instance_types_filters_max_gpu" {
  default     = null
  type        = number
  description = "Maximum total number of GPUs."
}
variable "instance_types_filters_min_gpu" {
  default     = null
  type        = number
  description = "Minimum total number of GPUs."
}
variable "instance_types_filters_max_memory_gib" {
  default     = null
  type        = number
  description = "Maximum amount of Memory (GiB)."
}
variable "instance_types_filters_max_network_performance" {
  default     = null
  type        = number
  description = "Maximum Bandwidth in Gib/s of network performance."
}
variable "instance_types_filters_max_vcpu" {
  default     = null
  type        = number
  description = "Maximum number of vcpus available."
}
variable "instance_types_filters_min_enis" {
  default     = null
  type        = number
  description = "Minimum number of network interfaces (ENIs)."
}
variable "instance_types_filters_min_memory_gib" {
  default     = null
  type        = number
  description = "Minimum amount of Memory (GiB)."
}
variable "instance_types_filters_min_network_performance" {
  default     = null
  type        = number
  description = "Minimum Bandwidth in Gib/s of network performance."
}
variable "instance_types_filters_min_vcpu" {
  default     = null
  type        = number
  description = "Minimum number of vcpus available."
}
variable "instance_types_filters_exclude_metal" {
  type        = bool
  default     = null
  description = "In case excludeMetal is set to true, metal types will not be available for scaling."
}
variable "instance_types_filters_is_ena_supported" {
  type        = bool
  default     = null
  description = "Ena is supported or not."
}
variable "instance_types_filters_categories" {
  type        = list(string)
  default     = null
  description = "The filtered instance types will belong to one of the categories types from this list. Valid values 'Accelerated_computing', 'Compute_optimized', 'General_purpose', 'Memory_optimized', 'Storage_optimized'"
}
variable "instance_types_filters_disk_types" {
  type        = list(string)
  default     = null
  description = "The filtered instance types will have one of the disk type from this list. Valid values 'NVMe', 'EBS', 'SSD', 'HDD'"
}
variable "instance_types_filters_exclude_families" {
  type        = list(string)
  default     = null
  description = "Types belonging to a family from the ExcludeFamilies will not be available for scaling (asterisk wildcard is also supported). For example, C* will exclude instance types from these families: c5, c4, c4a, etc."
}
variable "instance_types_filters_hypervisor" {
  type        = list(string)
  default     = null
  description = "The filtered instance types will have a hypervisor type from this list. Valid values 'nitro', 'xen'"
}
variable "instance_types_filters_include_families" {
  type        = list(string)
  default     = null
  description = "Types belonging to a family from the IncludeFamilies will be available for scaling (asterisk wildcard is also supported). For example, C* will include instance types from these families: c5, c4, c4a, etc."
}
variable "instance_types_filters_root_device_types" {
  type        = list(string)
  default     = null
  description = "Minimum number of vcpus available. Valid values 'ebs', 'instance-store'"
}
variable "instance_types_filters_virtualization_types" {
  type        = list(string)
  default     = null
  description = "The filtered instance types will support at least one of the virtualization types from this list. Valid values 'hvm', 'paravirtual'"
}

variable "instance_types_filters_enable" {
  type        = bool
  default     = null
  description = "'instance_types_filters_enable' to be set to true to have instance_types_filters configured in the virtual node group."
}

variable "images" {
  type = list(object({
    image_id   = string
  }))
  default     = null
  description = "Array of objects (Image object, containing the id of the image used to launch instances.)"
}
####################

## ephemeral_storage ##
variable "ephemeral_storage_device_name" {
  type        = string
  default     = null
  description = "Specify an alternative device name from which ephemeral storage calculations should be derived. This parameter is used when the ephemeral storage should not utilize the root device. Provide the device name configured in the VNG's BDM or AMI's BDM that differs from the default root device."
}
##################

variable "reserved_enis" {
  type        = number
  default     = 0
  description = "Specifies the count of ENIs to reserve per instance type for scaling purposes."
}

#instance_store_policy object
variable "instance_store_policy_type" {
  type        = string
  default     = null
  description = "Determines the utilization of instance store volumes. If not defined, instance store volumes will not be used. The method for using the instance store volumes (must also be defined in the userData)"
}

variable "startup_taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default     = null
  description = "Temporary taints applied to a node during its initialization phase. For a startup taint to work, it must also be set as a regular taint in the userData for the VNG."
}

## Load Balancers ##
variable "load_balancers" {
  type = list(object({
    arn  = optional(string, null)
    name = optional(string, null)
    type = string
  }))
  default     = null
  description = "load_balancer object"
}
##########################
