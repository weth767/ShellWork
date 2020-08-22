#!/bin/bash

# comando para buscar todos os arquivos do diretorio
files=$(find . -type f)
# Acessa todos os arquivos 
for i in $files; do
    # guarda o tipo de arquivo
    typ=$(file -b --mime-type $i)
    # replace na barra para não dar erro na criação do diretorio
    t=${typ//'/'/'-'}
    # verifica se o diretorio não existe
    if [ ! -d $t ] 
    then
    # cria o diretorio
        $(mkdir $t)
    fi
    # depois copia o arquivo para o diretorio
    $(cp $i $t)
done
