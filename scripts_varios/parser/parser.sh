#!/bin/bash
#Busca el estado del aire MALO e imprime esa linea y la siguente a "listado"
awk '/MALO/{print x; print};{x=$0}' reporte.asp > listado
awk '/MALO/{f=1;next}f{print;exit}' reporte.asp >> listado

#Se eliminan los tags HTML de 'listado' y se manda los datos limpios a "listado2"
sed -e 's/<[^>]*>//g' listado > listado2
#Se eliminan los espacios vacios de 'listado2' y se dejan en 'listado3'
sed 's/ //g' listado2 > listado3

#Se muestra el archivo final
cat listado3
