locals {
  name              = "test123"
  priority          = 100
  direction         = "Inbound"
  access            = "Allow"
  protocol          = "Tcp"
  source_port_range = "*"
  dest_port_range   = "*"
  source_addr_prfix = "*"
  dest_addr_prfix   = "*"
  eight             = "8"

}