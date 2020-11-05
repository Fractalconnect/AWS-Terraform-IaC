resource "aws_instance" "CEN-K8-srv" {
    count                  = 1
    ami                    = var.kubernetes_ami
    instance_type          = var.master_instance_type
    vpc_security_group_ids = [aws_security_group.K8-sg.id]
    subnet_id              = element(aws_subnet.CEN-fractal-subnet.*.id, count.index)
    key_name               = var.key_name

    tags = {
      Name = "CEN-K8-srv"
      Type = "K8-Master"
    }
}

resource "aws_instance" "CEN-K8-workers" {
    count                  = 2
    ami                    = var.kubernetes_ami
    instance_type          = var.master_instance_type
    vpc_security_group_ids = [aws_security_group.K8-sg.id]
    subnet_id              = element(aws_subnet.CEN-fractal-subnet.*.id, count.index)
    key_name = var.key_name

    tags = {
      Name = "CEN-K8-srv"
      Type = "K8-Worker"
    }
}