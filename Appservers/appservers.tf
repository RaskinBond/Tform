resource "aws_key_pair" "keypair" {
  key_name   = "fromtf"
  public_key = file("~/.ssh/id_rsa.pub")
  
  depends_on = [
    aws_db_instance.database
  ]
}

resource "aws_instance" "appservers" {
    count                       = var.appserver_info.count
    ami                         = var.appserver_info.ami_id
    associate_public_ip_address = var.appserver_info.public_ip_enabled
    instance_type               = var.appserver_info.instance_type
    key_name                    = aws_key_pair.keypair.key_name
    subnet_id                   = data.aws_subnets.app_subnets.ids[count.index]
    vpc_security_group_ids      = [aws_security_group.App_server.id]
    
    tags = {
    Name                        = format("%s-%d",var.appserver_info.name, count.index+1)
    }
    depends_on = [
      aws_key_pair.keypair
    ]
}

