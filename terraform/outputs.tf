output "rds_endpoint" {
  description = "The endpoint to reach DB from EC2"
  value       = aws_db_instance.database.endpoint
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
