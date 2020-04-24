Los siguientes comandos se utilizan para montar la infraestructura, tener en cuenta que se deben agregar las credenciales de aws.

terraform init

terraform validate -> les hace el check de todo. Mejor usar antes del plan

terraform plan

terraform apply

teraform destroy # si ocurren errores

terraform show -> para ver el estado actual

terraform fmt -> formatea el código para evitar bad merged por espacios.
