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