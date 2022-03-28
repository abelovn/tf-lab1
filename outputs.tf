

output "vpc_id_with_cidr" {
  description = "main VPC id"
  value       = "${data.aws_vpc.main_vpc.id} = ${data.aws_vpc.main_vpc.cidr_block}"
}

output "subnet_ids_with_cidrs" {
  value = [for s in data.aws_subnet.subnet : "${s.id} = ${s.cidr_block}"]
}

output "security_groups_names" {
  description = "Names of security_groups"
  value = {
    for k, sg in data.aws_security_group.security_group : k => sg.name
  }
}
