data "aws_availability_zones" "availableAZ" {}

# Create private subnets
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = var.private_cidr[count.index] 
  availability_zone = data.aws_availability_zones.availableAZ.names[count.index]
  vpc_id            = var.vpc.id
  
  tags = {
    Name = "${var.environment}-private"
  }

}

# Create public subnets
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = var.public_cidr[count.index] 
  availability_zone       = data.aws_availability_zones.availableAZ.names[count.index]
  vpc_id                  = var.vpc.id
  map_public_ip_on_launch = true
  
  tags = {
    Name = "${var.environment}-public"
  }

}

# Internet Gateway
resource "aws_internet_gateway" "IGateWay" {
  vpc_id = var.vpc.id
  
  tags = {
    Name = "${var.environment}-IGateWay"
  }

}

resource "aws_route" "internet_access" {
  depends_on = [aws_internet_gateway.IGateWay]
  route_table_id         = var.vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGateWay.id
}

# Create a NAT gateway with an Elastic IP
resource "aws_eip" "NatGateWayIP" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.IGateWay]
  
  tags = {
    Name = "${var.environment}-ElasticIP"
  }

}

resource "aws_nat_gateway" "NatGateWay" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.NatGateWayIP.*.id, count.index)
  
  tags = {
    Name = "${var.environment}-Nat_GateWay"
  }

}

# Create a new route table for the private subnets
resource "aws_route_table" "private_route" {
  count  = var.az_count
  vpc_id = var.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.NatGateWay.*.id, count.index)
  }

  tags = {
    Name = "${var.environment}-Route_table_private"
  }

}

# Association for private subnets
resource "aws_route_table_association" "private" {
  depends_on = [aws_route_table.private_route]
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private_route.*.id, count.index)
}