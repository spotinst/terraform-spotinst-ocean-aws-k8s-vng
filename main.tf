## Create Virtual Node group (Launch Spec)
resource "spotinst_ocean_aws_launch_spec" "nodegroup" {
  ocean_id             = var.ocean_id
  name                 = var.name
  user_data            = var.user_data
  image_id             = var.image_id
  iam_instance_profile = var.iam_instance_profile
  security_groups      = var.security_groups
  subnet_ids           = var.subnet_ids
  instance_types       = var.instance_types
  preferred_spot_types = var.preferred_spot_types
  preferred_od_types   = var.preferred_od_types
  root_volume_size     = length(var.block_device_mappings) == 0 ? var.root_volume_size : null
  reserved_enis        = var.reserved_enis

  #Optional, tags will be inherited by the default launchspec configured in the ocean_aws resource
  dynamic "tags" {
    for_each = var.tags == null ? {} : var.tags
    content {
      key   = tags.key
      value = tags.value
    }
  }

  associate_public_ip_address = var.associate_public_ip_address
  restrict_scale_down         = var.restrict_scale_down

  instance_metadata_options {
    http_tokens                 = var.http_tokens
    http_put_response_hop_limit = var.http_put_response_hop_limit
  }

  dynamic "labels" {
    for_each = var.labels == null ? [] : var.labels
    content {
      key   = labels.value["key"]
      value = labels.value["value"]
    }
  }

  dynamic "load_balancers" {
    for_each = var.load_balancers != null ? var.load_balancers : []
    content {
      arn  = load_balancers.value.arn
      name = load_balancers.value.name
      type = load_balancers.value.type
    }
  }

  dynamic "taints" {
    for_each = var.taints == null ? [] : var.taints
    content {
      key    = taints.value["key"]
      value  = taints.value["value"]
      effect = taints.value["effect"]
    }
  }

  ## Elastic_ip_pool
  elastic_ip_pool {
    dynamic "tag_selector" {
      for_each = var.elastic_ip_pool_tag_selector == null ? {} : var.elastic_ip_pool_tag_selector
      content {
        tag_key   = tag_selector.key
        tag_value = tag_selector.value
      }
    }
  }

  ## Block Device Mappings ##
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name
      no_device   = try(block_device_mappings.value.no_device, null)

      dynamic "ebs" {
        for_each = (
          try(
            block_device_mappings.value.delete_on_termination,
            block_device_mappings.value.encrypted,
            block_device_mappings.value.iops,
            block_device_mappings.value.kms_key_id,
            block_device_mappings.value.snapshot_id,
            block_device_mappings.value.volume_type,
            block_device_mappings.value.volume_size,
            block_device_mappings.value.throughput,
            null
          ) != null ? [block_device_mappings.value] : []
        )
        content {
          delete_on_termination = try(ebs.value.delete_on_termination, null)
          encrypted             = try(ebs.value.encrypted, null)
          iops                  = try(ebs.value.iops, null)
          kms_key_id            = try(ebs.value.kms_key_id, null)
          snapshot_id           = try(ebs.value.snapshot_id, null)
          volume_type           = try(ebs.value.volume_type, null)
          volume_size           = try(ebs.value.volume_size, null)
          throughput            = try(ebs.value.throughput, null)

          dynamic "dynamic_volume_size" {
            for_each = var.dynamic_volume_size != null ? [var.dynamic_volume_size] : []
            content {
              base_size              = try(dynamic_volume_size.value.base_size, null)
              resource               = try(dynamic_volume_size.value.resource, null)
              size_per_resource_unit = try(dynamic_volume_size.value.size_per_resource_unit, null)
            }
          }
          dynamic "dynamic_iops" {
            for_each = var.dynamic_iops != null ? [var.dynamic_iops] : []
            content {
              base_size              = dynamic_iops.value.base_size
              resource               = dynamic_iops.value.resource
              size_per_resource_unit = dynamic_iops.value.size_per_resource_unit
            }
          }
        }
      }
    }
  }

  ephemeral_storage{
    ephemeral_storage_device_name = var.ephemeral_storage_device_name
  }

  autoscale_headrooms_automatic {
    auto_headroom_percentage = var.auto_headroom_percentage
  }

  autoscale_down {
    max_scale_down_percentage        = var.max_scale_down_percentage
    is_aggressive_scale_down_enabled = var.is_aggressive_scale_down_enabled
  }

  autoscale_headrooms {
    cpu_per_unit    = var.cpu_per_unit
    memory_per_unit = var.memory_per_unit
    gpu_per_unit    = var.gpu_per_unit
    num_of_units    = var.num_of_units
  }

  resource_limits {
    min_instance_count = var.min_instance_count
    max_instance_count = var.max_instance_count
  }

  strategy {
    spot_percentage  = var.spot_percentage
    draining_timeout = var.draining_timeout
    utilize_commitments = var.utilize_commitments
    utilize_reserved_instances = var.utilize_reserved_instances
    orientation {
      availability_vs_cost = var.availability_vs_cost
    }
  }

  create_options {
    initial_nodes = var.initial_nodes
  }

  delete_options {
    force_delete = var.force_delete
    delete_nodes = var.delete_nodes
  }


  dynamic "scheduling_task" {
    for_each = var.scheduling_task != null ? var.scheduling_task : []
    content {
      is_enabled      = scheduling_task.value.is_enabled
      cron_expression = scheduling_task.value.cron_expression
      task_type       = scheduling_task.value.task_type
      task_headroom {
        num_of_units    = scheduling_task.value.num_of_units
        cpu_per_unit    = scheduling_task.value.cpu_per_unit
        gpu_per_unit    = scheduling_task.value.gpu_per_unit
        memory_per_unit = scheduling_task.value.memory_per_unit
      }
    }
  }

  dynamic "scheduling_shutdown_hours" {
    for_each = var.scheduling_shutdown_hours != null ? [var.scheduling_shutdown_hours] : []
    content {
      time_windows = scheduling_shutdown_hours.value.time_windows
      is_enabled   = scheduling_shutdown_hours.value.is_enabled
    }
  }

  update_policy {
    should_roll = var.should_roll
    roll_config {
      batch_size_percentage = var.batch_size_percentage
      respect_pdb           = var.respect_pdb
    }
  }

  dynamic "instance_types_filters" {
    for_each = var.instance_types_filters_enable == true ? [var.instance_types_filters_enable] : []
    content {
      categories                =   var.instance_types_filters_categories
      disk_types                =   var.instance_types_filters_disk_types
      exclude_families          =   var.instance_types_filters_exclude_families
      exclude_metal             =   var.instance_types_filters_exclude_metal
      hypervisor                =   var.instance_types_filters_hypervisor
      include_families          =   var.instance_types_filters_include_families
      is_ena_supported          =   var.instance_types_filters_is_ena_supported
      max_gpu                   =   var.instance_types_filters_max_gpu
      min_gpu                   =   var.instance_types_filters_min_gpu
      max_memory_gib            =   var.instance_types_filters_max_memory_gib
      max_network_performance   =   var.instance_types_filters_max_network_performance
      max_vcpu                  =   var.instance_types_filters_max_vcpu
      min_enis                  =   var.instance_types_filters_min_enis
      min_memory_gib            =   var.instance_types_filters_min_memory_gib
      min_network_performance   =   var.instance_types_filters_min_network_performance
      min_vcpu                  =   var.instance_types_filters_min_vcpu
      root_device_types         =   var.instance_types_filters_root_device_types
      virtualization_types      =   var.instance_types_filters_virtualization_types
    }
  }

  dynamic "images" {
    for_each = var.images == null ? [] : var.images
    content {
      image_id   = images.value["image_id"]
    }
  }

  instance_store_policy {
    instance_store_policy_type = var.instance_store_policy_type
  }


  dynamic "startup_taints" {
    for_each = var.startup_taints == null ? [] : var.startup_taints
    content {
      key    = startup_taints.value["key"]
      value  = startup_taints.value["value"]
      effect = startup_taints.value["effect"]
    }
  }

}
