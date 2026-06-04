#--------------------------------------------
# VPC
#--------------------------------------------
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.project_name}-vpc-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Public Subnets (2 AZs for high availability)
#--------------------------------------------
resource "aws_subnet" "public" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet-${count.index + 1}-${var.environment}"
    Type        = "Public"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Private Subnets (2 AZs for high availability)
#--------------------------------------------
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project_name}-private-subnet-${count.index + 1}-${var.environment}"
    Type        = "Private"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Internet Gateway (Public Internet Access)
#--------------------------------------------
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Public Route Table (routes traffic to IGW)
#--------------------------------------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-route-table-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Private Route Tables (one per subnet)
# Best practice — independent routing per AZ
# Makes NAT Gateway addition easier in future
#--------------------------------------------
resource "aws_route_table" "private" {
  count  = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-private-route-table-${count.index + 1}-${var.environment}"
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

#--------------------------------------------
# Route Table Associations
#--------------------------------------------
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}