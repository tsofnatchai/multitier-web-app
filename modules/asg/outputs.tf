output "asg_id" {
  description = "The ID of the Auto Scaling Group"
  value       = module.asg.autoscaling_group_id
}
