Add bitcoin prince to your i3wm status bar:

1. Clone this repo `git clone git@github.com:boris/btc-price.git ~/.btc-price`
2. Add the following to your `i3blocks.conf`:

```
# Bitcoin Price                                       
[script]                                              
label=BTC:                                            
command=ruby ~/.btc-price/price.rb
interval=90                                           
```

![](http://irc.zsh.io/files/1517236654.png)
