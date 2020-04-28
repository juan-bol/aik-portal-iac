terraform init
terraform validate -> les hace el check de todo. Mejor usar antes del plan
terraform plan
terraform apply
teraform destroy # si se putea

terraform show -> para ver el estado actual
terraform fmt -> formatea el código para evitar bad merged por espacios.

# Comentarios al Main .tf

Organicen los archivos de Terraform en otro directorio

Esta forma de escribir esta deprecated. Por favor utilicen Terraform 12. 
´´´
resource "aws_internet_gateway" "aik-igw" {
    vpc_id = "${aws_vpc.aik-vpc.id}"
}
´´´

Al recurso VPC, Les hace falta: dar enable al DNS. Es importante para el acceso al portal. Sino quedan con un acceso mediante ip solamente. La idea es que las IP se pasan por variable.



