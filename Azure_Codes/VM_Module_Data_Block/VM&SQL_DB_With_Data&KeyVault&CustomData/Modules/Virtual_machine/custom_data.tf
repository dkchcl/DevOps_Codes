variable "nginx_custom_data" {
  default = <<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y nginx
  systemctl enable nginx
  systemctl start nginx
EOF
}