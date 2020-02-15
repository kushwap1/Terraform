output "Bucket_name" {
  value = module.storage.bucketname
}

output "public_subnets" {
  value = module.networking.public_subnets
}

output "public_sg" {
  value = module.networking.public_sg
}

output "subnet_ips" {
  value = module.networking.subnet_ips
}

#---Compute Outputs ------

output "Public_Instance_IDs" {
  value = module.compute.server_id
}

output "Public_Instance_IPs" {
  value = module.compute.server_ip
}
