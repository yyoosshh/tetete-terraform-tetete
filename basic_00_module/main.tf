provider "aws" {
  region = "ap-northeast-1"
}

module "web_server" {
  source        = "./modules/web_server"
  instance_type = "t4g.micro"
}

output "public_dns" {
  value = module.web_server.public_dns
}
