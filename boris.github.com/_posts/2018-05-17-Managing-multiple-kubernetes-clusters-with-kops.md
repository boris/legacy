---
layout: post
title: Managing multiple kubernetes clusters with kops
date: 2018-05-17
---
Desde hace un tiempo vengo usando [kops](https://github.com/kubernetes/kops)
para el deploy de kubernetes en AWS, a la espera de que los amigos de AWS se
dignen a habilitar EKS en mi cuenta...
El tema es que hasta ahora no he encontrado la forma de manejar bien el cambio
de contexto de cada cluster. Por ejemplo, si estoy en el cluster-a, y por lo
tanto en mis variables de entorno está definido el cluster-a, pero necesito ir
al cluster-b, cómo lo hago?

Para resolverlo, copié la forma en que en un trabajo anterior manejábamos los
contextos de openstack, que es usando un archivito de mierda con los exports
correspondientes y listo. De esta forma, ahora en mi `$HOME` tengo un directorio
`.kops` que dentro tiene archivos que definen cada uno de los clusters. Por
ejemplo, el cluster de staging de virginia tiene lo siguiente:

```
➜ cat stg.ue1
export KOPS_STATE_STORE=s3://k8s-zsh-io-state-store
export CLUSTER_NAME=stg.ue1.k8s.local
```

Entonces, cuando quiero cambiarme a ese cluster hago `. .kops/stg-ue1` y listo!


**Next steps**: Pienso modificar mi `.zshrc` para mostrar información relacionada
con esto.
