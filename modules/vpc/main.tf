resource "aws_vpc" "main" {
    cidr_block           = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support   = true

    tags = {
        Name        = "${var.project_name}-vpc"
        Environment = var.environment
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name        = "${var.project_name}-igw"
        Environment = var.environment
    }
}

resource "aws_subnet" "public_1" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_1_cidr
    availability_zone       = "${var.aws_region}a"
    map_public_ip_on_launch = true

    tags = {
        Name        = "${var.project_name}-public_1"
        Environment = var.environment
    }
}

resource "aws_subnet" "public_2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.public_subnet_2_cidr
    availability_zone       = "${var.aws_region}b"
    map_public_ip_on_launch = true

    tags = {
        Name        = "${var.project_name}-public_2"
        Environment = var.environment
    }
}

resource "aws_subnet" "private_1" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_1_cidr
    availability_zone = "${var.aws_region}a"

    tags = {
        Name        ="${var.project_name}-private-1"
        Environment = var.environment
    }
}

resource "aws_subnet" "private_2" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.private_subnet_2_cidr
    availability_zone = "${var.aws_region}b"

    tags = {
        Name        ="${var.project_name}-private-2"
        Environment = var.environment
    }
}

resource "aws_subnet" "database_1" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.database_subnet_1_cidr
    availability_zone = "${var.aws_region}a"

    tags = {
        Name        = "${var.project_name}-database-1"
        Environment = var.environment
    }
}

resource "aws_subnet" "database_2" {
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.database_subnet_2_cidr
    availability_zone = "${var.aws_region}b"

    tags = {
        Name        = "${var.project_name}-database-2"
        Environment = var.environment
    }
}

resource "aws_eip" "nat" {
    domain = "vpc"

    tags = {
        Name        = "${var.project_name}-nat-eip"
        Environment = var.environment
    }
}

resource "aws_nat_gateway" "main" {
    allocation_id = aws_eip.nat.id
    subnet_id     = aws_subnet.public_1.id

   tags = {
    Name        = "${var.project_name}-nat"
    Environment = var.environment
    }

    depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }

    tags = {
        Name        = "${var.project_name}-public-rt"
        Environment = var.environment
    }
}

resource "aws_route_table" "private" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.main.id
    }

    tags = {
     Name        = "${var.project_name}-private-rt"
     Environment = var.environment  
    }
}

resource "aws_route_table_association" "public_1" {
    subnet_id      = aws_subnet.public_1.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
    subnet_id      = aws_subnet.public_2.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private_1" {
    subnet_id      = aws_subnet.private_1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
    subnet_id      = aws_subnet.private_2.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database_1" {
    subnet_id      = aws_subnet.database_1.id
    route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "database_2" {
    subnet_id      = aws_subnet.database_2.id
    route_table_id = aws_route_table.private.id
}