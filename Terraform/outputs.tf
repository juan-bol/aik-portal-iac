output "IP-PORTAL" {
  value = "${aws_launch_configuration.aik-lcfg.public_ip}"
}