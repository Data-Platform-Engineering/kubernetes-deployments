module "argocd_vpc" {
  source = "./modules/vpc"
    vpc_name = "argocd-vpc"
    vpc_cidr = "10.0.0.0/16"
    vpc_owner = "argocd-owner"

}

#get availability zones available
data "aws_availability_zones" "azs" {
  state = "available"
}


#argocd ec2 subnet
module "argocd_subnet" {
  source = "./modules/subnets"
  vpc_id = module.argocd_vpc.vpc_id
  subnet_cidr = "10.0.0.0/24"
  az = data.aws_availability_zones.azs.names[0]
  subnet_name = "argocd_subnet"
  subnet_owner ="argocd-owner"
}


# internet gateway
# Create an Internet Gateway
resource "aws_internet_gateway" "argocd" {
  vpc_id = module.argocd_vpc.vpc_id

  tags = {
    Name = "argocd-ec2-igw"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "argocd_ec2_public_rt" {
  vpc_id = module.argocd_vpc.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.argocd.id
    }

   tags = {
     Name = "argocd-ec2-route-table"
     Owner= "argocd-owner"
   }
 }

# route table association
resource "aws_route_table_association" "argocd_ec2_rt_association" {
   subnet_id = module.argocd_subnet.subnet_id
   route_table_id = aws_route_table.argocd_ec2_public_rt.id
 }
