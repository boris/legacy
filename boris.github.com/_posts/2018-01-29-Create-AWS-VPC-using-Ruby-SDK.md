---
layout: post
title: Create AWS VPC using Ruby SDK
date: 2018-01-29
---
Hace algún tiempo vengo pensando que una buena forma de practicar algo que
aprendí a hacer es programar una forma de hacerlo automático. Le veo varios
beneficios, entre los que destaco:
- Mejor entendimiento del proceso: debo tenerlo lo suficientemente claro como
    para llevarlo a código
- Aprovecho de practicar algún lenguaje de programación
- A medida que voy escribiendo el código, voy repasando y recordando, hasta
    ahora diría que "para siempre", cada uno de los pasos a seguir.

Esto lo vengo aplicando principalmente a procesos repetitivos que he ido
observado en el trabajo, pero el ejemplo de hoy es algo poco frecuente pero que
tiene tantas partes que me pareció entretenido programar: El desafío era hacer
un pequeño código en ruby que permitiera levantar una VPC preguntando los
diferentes parámetros de configuración de una VPC (y asumiendo algunos otros).

## Proceso
Todo partió con una definición de lo que se necesita para levantar una VPC, que
es más o menos esto:
```
1. Crear VPC, asignar rango de IP (10.0.0.0/16)
2. Crear al menos
  - Una subnet pública (10.0.1.0/24)
  - Una subnet privada (10.0.2.0/24)
3. Crear un Internet Gateway y atacharlo a la VPC
4. Crear un NAT Gateway (debe estar en la VPC pública)
5. Routing table
  - Asignar la subnet pública al Internet GW con destination 0.0.0.0/0
  - Asingar la subnet privada al NAT GW con destination 0.0.0.0/0
```
Lo anterior luego se transformó en una lista de comando utilizando
[awscli](https://github.com/aws/aws-cli):
```
aws ec2 create-vpc --cidr-block 10.240.0.0/16 
aws ec2 create-subnet --vpc-id <VPC-ID> --cidr-block 10.240.1.0/24 #private
aws ec2 create-subnet --vpc-id <VPC-ID> --cidr-block 10.240.2.0/24 #public
aws ec2 create-internet-gateway
aws ec2 attach-internet-gateway --vpc-id <VPC-ID> --internet-gateway-id <IGW-ID>
aws ec2 create-route-table --vpc-id <VPC-ID>
aws ec2 create-route --route-table-id <RouteTable-ID> --destination-cidr-block 0.0.0.0/0 --gateway-id <IGW-ID>
aws ec2 associate-route-table --subnet-id <PublicSubnet-ID> --route-table-id <RouteTable-ID>
```
Y finalmente en un script en ruby [que está disponible
acá](https://github.com/boris/aws-tools/blob/master/ec2-create_vpc.rb). Ahora
que vuelvo a revisar el script, ya se me ocurrieron varias mejoras, como
verificación de las subnets y manejo de errores. Espero algún día
implementarlas.
