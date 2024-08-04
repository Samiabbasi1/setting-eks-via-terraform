resource "aws_eip" "eip-nat-gw1" {
  vpc = true
  tags = {
    name = "eip-nat-gw1"
  }
}

resource "aws_eip" "eip-nat-gw2" {
  vpc = true
  tags = {
    name = "eip-nat-gw2"
  }
}

resource "aws_nat_gateway" "nat-gw1" {
    allocation_id = aws_eip.eip-nat-gw1.id
    subnet_id = var.pub_sub1_id
    tags = {
      name = "nat-gw1"
    }
    depends_on = [ var.igw_id ]
}

resource "aws_nat_gateway" "nat-gw2" {
    allocation_id = aws_eip.eip-nat-gw2.id
    subnet_id = var.pub_sub2_id
    tags = {
      name = "nat-gw2"
    }
    depends_on = [ var.igw_id ]
}

resource "aws_route_table" "pri-rt-a" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw1.id
  }
  tags = {
    name = "pri-rt-a"
  }
}

resource "aws_route_table" "pri-rt-b" {
    vpc_id = var.vpc_id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_eip.eip-nat-gw2.id
    }
    tags = {
      name = "pri-rt-b"
    }
}

resource "aws_route_table_association" "pri-sub3-with-pri-rt-a" {
  subnet_id = var.pri_sub3_id
  route_table_id = aws_route_table.pri-rt-a.id
}

resource "aws_route_table_association" "pri-sub4-with-pri-rt-b" {
  subnet_id = var.pri_sub4_id
  route_table_id = aws_route_table.pri-rt-b.id
}

