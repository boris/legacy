---
layout: post
title: Probando el coloreado de codigo
date: 2013-02-15 00:00:00.000000000 -03:00
---
Algo importante que me hizo optar por [Jekyll](http://jekyllbootstrap.com) es que conoce (y por lo tanto _reslta_) la sintaxis de más de 100 lenguajes. Esto es posible gracias a [Pygments](http://pygments.org/) y [acá](http://pygments.org/languages/) está el listado completo de lenguajes soportados.

El problema de Pygments es que, al ser Python, no funciona bien en Heroku. Para resolver esto, hay una solución usando una _gem_ llamada [Pygmentize](http://rubygems.org/gems/pygmentize). La instalación es obvia: `gem install pygmentize`, pero recomiendo usar el archivo `Gemfile` para no tener problemas en Heroku.

Junto con esto, hay que crear un nuevo plugin para Jekyll: `_posts/highlight.rb`. Acá les dejo el contenido:

{% highlight ruby %}
require 'pygmentize'
class Jekyll::HighlightBlock < Liquid::Block
  def render_pygments(context, code)
    @options[:encoding] = 'utf-8'
    output = add_code_tags(
      Pygmentize.process(code, @lang),
      @lang
    )

    output = context["pygments_prefix"] + output if context["pygments_prefix"]
    output = output + context["pygments_suffix"] if context["pygments_suffix"]
    output
  end
end
{% endhighlight %}

Veamos algunos ejemplos:

**Ruby**
{% highlight ruby %}
def hello
	puts "Hello world!"
end
{% endhighlight %}

**Python**
{% highlight python %}
def main():
	print 'Hello world!'

if __name__ == '__main__':
	main()
{% endhighlight %}

**BASH**
{% highlight bash %}
#!/bin/bash
echo "Hello world!"
{% endhighlight %}
