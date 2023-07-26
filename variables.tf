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
  default     = null
  description = "Determines if a signed token is required or not. Valid values: 'optional' or 'required'."

  validation {
    condition     = contains(["optional", "required"], var.http_tokens)
    error_message = "Valid values: 'optional' or 'required'."
  }
}

variable "http_put_response_hop_limit" {
  type        = number
  default     = null
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
  type = list(object({
    device_name           = string
    delete_on_termination = bool
    encrypted             = bool
    kms_key_id            = string
    snapshot_id           = string
    volume_type           = string
    iops                  = number
    volume_size           = number
    throughput            = number
    no_device             = string
  }))
  default     = []
  description = "Block Device Mapping Object"
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
###################

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
##################
