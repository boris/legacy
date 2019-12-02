---
layout: post
title: Simples consejos para la seguridad de tus servidores
date: 2013-10-22 00:00:00.000000000 -03:00
---
Cuando tu trabajo es hacerte responsable por los servidores de una empresa debes preocuparte mucho de la seguridad. Algunos presta especial atención a la seguridad perimetral de sus sistemas a fin de evitar que personas externas a la empresa tengan acceso a la información. Otros, se gastan un montón de plata pagando por *productos* que dicen protegernos ante todo.

Pero, alguien se preocupa de la seguridad personal? Ya sé que exiten medidas de control de acceso a donde están los servidores y todas esas cosas que enseñan en las capacitaciones que pagan las empresas, pero alguien va más allá?

Les voy a contar mi experiencia personal, en realidad parte de ella, respecto a la seguridad *personal*. Como sabrán, mi trabajo básicamente es preocuparme de servidores de empresas y por lo tanto -tal como dije arriba- debo preocuparme, entre otras cosas, de la seguridad y para eso pongo en práctica varias cosas que están disponibles para todos, como por ejemplo:

- Claves publicas: Supongo que ya nadie se conecta a su server con user/password.
- AllowUsers: Lo mejor(?) que tiene SSH.
- Puerto del ssh: NO es el 22, verdad? verdad?!
- Pendrive: aquí me detendré

Si ud. alguna vez me ve trabajando, verá que mi laptop generalmente está así:

![laptop](/images/laptop-pendrive.jpg)

Dentro de ése pendrive están, entre otras cosas, las claves ssh que uso para conectarme a todos mis servidores y algunas configuraciones de ssh. El funcionamiento es simple y se lo podrán imaginar: En cierta parte de mi /home hay un *symlink* al punto de montaje del pendrive. Si el pendrive no está conectado, no hay forma de poder conectarse a los servidores. Mencioné que el pendrive está encriptado? Bueno, lo está... 

En caso de que se pierda, no quiero que nadie tenga acceso a esos datos. Y en el mismo caso -que se me pierda- hay un par de backups distribuídos por las interneces...

Además de eso, hay 2 medidas de seguridad más pero por razones obvias no las puedo mencionar :)

Les dejo este post como idea para que ustedes mismos puedan desarrollar sus sistemas de seguridad.

---  
Nota: El pendrive de la imagen no es el real, por si alguien me lo quiere robar :)
