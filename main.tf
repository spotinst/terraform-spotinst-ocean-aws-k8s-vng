## Create Virtual Node group (Launch Spec)
resource "spotinst_ocean_aws_launch_spec" "nodegroup" {
  ocean_id                    = var.ocean_id
  name                        = var.name
  user_data                   = var.user_data
  image_id                    = var.ami_id
  iam_instance_profile        = var.worker_instance_profile_arn
  security_groups             = var.security_groups
  subnet_ids                  = var.subnet_ids
  instance_types              = var.instance_types
  preferred_spot_types        = var.preferred_spot_types
  #root_volume_size            = var.root_volume_size


  # Required tags
  tags {
    key = "Name"
    value = "${var.cluster_name}-ocean-cluster-node"
  }
  tags {
    key = "kubernetes.io/cluster/${var.cluster_name}"
    value = "owned"
  }

  # Default Tags
  dynamic tags {
    for_each = data.aws_default_tags.default_tags.tags
    content {
      key = tags.key
      value = tags.value
    }
  }

  dynamic tags {
    for_each = var.tags == null ? {} : var.tags
    content {
      key = tags.key
      value = tags.value
    }
  }

  associate_public_ip_address = var.associate_public_ip_address
  restrict_scale_down         = var.restrict_scale_down

  dynamic labels {
    for_each = var.labels == null ? [] : var.labels
    content {
      key = labels.value["key"]
      value = labels.value["value"]
    }
  }

  dynamic taints {
    for_each = var.taints == null ? [] : var.taints
    content {
      key = taints.value["key"]
      value = taints.value["value"]
      effect = taints.value["effect"]
    }
  }

  ## Elastic_ip_pool
  elastic_ip_pool {
    tag_selector {
      tag_key   = var.elastic_ip_pool_tag_selector_key
      tag_value = var.elastic_ip_pool_tag_selector_value
    }
  }
  ## Block Device Mappings ##
  block_device_mappings {
    device_name                 = var.device_name
    ebs {
      delete_on_termination     = var.delete_on_termination
      encrypted                 = var.encrypted
      iops                      = var.iops
      kms_key_id                = var.kms_key_id
      snapshot_id               = var.snapshot_id
      volume_type               = var.volume_type
      //volume_size             = var.volume_size
      throughput                = var.throughput
      dynamic_volume_size {
        base_size               = var.base_size
        resource                = var.resource
        size_per_resource_unit  = var.size_per_resource_unit
      }
      //no_device                 = var.no_device
    }
  }

  autoscale_headrooms {
    cpu_per_unit                = var.cpu_per_unit
    memory_per_unit             = var.memory_per_unit
    gpu_per_unit                = var.gpu_per_unit
    num_of_units                = var.num_of_units
  }

  resource_limits {
    min_instance_count          = var.min_instance_count
    max_instance_count          = var.max_instance_count
  }

  strategy {
    spot_percentage             = var.spot_percentage
  }

  create_options {
    initial_nodes               = var.initial_nodes
  }

  delete_options {
    force_delete                = var.force_delete
  }
}