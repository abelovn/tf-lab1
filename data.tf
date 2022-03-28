
data "aws_vpc" "main_vpc" {
     filter {
        name   = "tag:Owner"
        values = ["a.belov.n@gmail.com"]
  }
}

data "aws_subnet_ids" "existing_subnets" {
    filter {
        name   = "tag:Owner"
        values = ["a.belov.n@gmail.com"]

    }
    vpc_id = data.aws_vpc.main_vpc.id
}

data "aws_subnet" "subnet" {
    filter {
        name   = "tag:Owner"
        values = ["a.belov.n@gmail.com"]
    }    

    for_each   = data.aws_subnet_ids.existing_subnets.ids
    id         = each.value    
}

data "aws_security_groups" "security_groups" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main_vpc.id]
  }
}

data "aws_security_group" "security_group" {
  for_each = { for sg in data.aws_security_groups.security_groups.ids : sg => sg }
  id       = each.value
}
