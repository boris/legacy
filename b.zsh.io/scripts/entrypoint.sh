#!/bin/bash
FILE=https://raw.githubusercontent.com/boris/b.zsh.io/master/templates/index.html
CSS=https://raw.githubusercontent.com/boris/b.zsh.io/master/static/css/style.css

get_content(){
    echo "Downloading HTML file"
    curl $FILE -o /app/templates/index.html
    echo "Downloading CSS file"
    curl $CSS -o /app/static/css/style.css
}

get_content
python main.py
