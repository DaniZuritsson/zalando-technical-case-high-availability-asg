# 1. Security Group for the Application Load Balancer (ALB)
resource "aws_security_group" "alb" {
  name        = "zalando-alb-sg"
  description = "Allow public HTTP inbound traffic to the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow HTTP from public internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zalando-alb-security-group"
  }
}

# 2. Security Group for Private EC2 Instances (App Servers)
resource "aws_security_group" "ec2" {
  name        = "zalando-ec2-sg"
  description = "Allow inbound traffic restricted only to the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "Allow traffic strictly from the ALB security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "zalando-ec2-security-group"
  }
}