output "virtual_node_group_id" {
  value = spotinst_ocean_aws_launch_spec.nodegroup.id
  description = "The Ocean cluster launchspec (Virtual Node Group) ID"
}