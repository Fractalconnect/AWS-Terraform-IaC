resource "aws_security_group" "K8-sg" {
    name        = "Allow_All_Ports"
    description = "Allow All Poers All Protocols"
    vpc_id      = aws_vpc.CEN-fractal_vpc1.id
    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}