#!/bin/bash
# método para organizar por tipo(mime)
organizeByType() {
    # comando para buscar todos os arquivos do diretorio
    files=$(find . -type f)
    # Acessa todos os arquivos 
    for i in $files; do
        # guarda o tipo de arquivo
        typ=$(file -b --mime-type $i)
        # pega o nome do arquivo dado um caminho
        filename=$(basename -a $i)
        # replace na barra para não dar erro na criação do diretorio
        t=${typ//'/'/'-'}
        # verifica se o diretorio não existe
        if [ ! -d $t ] 
        then
        # cria o diretorio
            $(mkdir $t)
        fi
        # verifica se o arquivo já existe na pasta
        path=$t'/'$filename
        if [ ! -f $path ]
        then
            # depois copia o arquivo para o diretorio
            $(cp -u -f $i $t)
        fi
    done
}

# método para organizar o arquivo por nome(primeira letra)
organizeByName() {
     # comando para buscar todos os arquivos do diretorio
    files=$(find . -type f)
    # Acessa todos os arquivos 
    for i in $files; do
        filename=$(basename -a $i)
        firstLetter=${filename:0:1}
        dir=${firstLetter^^}
        if [ ! -d $dir ] 
        then
        # cria o diretorio
            $(mkdir $dir)
        fi
        # verifica se o arquivo já existe na pasta
        path=$dir'/'$filename
        if [ ! -f $path ]
        then
            # depois copia o arquivo para o diretorio
            $(cp -u -f $i $dir)
        fi
    done
}

# Método para organizar por data
organizeByDate() {
    # comando para buscar todos os arquivos do diretorio
    files=$(find . -type f)
    # Acessa todos os arquivos 
    for i in $files; do
        # guarda a data da ultima alteração do arquivo
        date=$(date -r $i "+%Y-%m-%d")
        # pega o nome do arquivo dado um caminho
        filename=$(basename -a $i)
        # verifica se o diretorio não existe
        if [ ! -d $date ] 
        then
        # cria o diretorio
            $(mkdir $date)
        fi
        # verifica se o arquivo já existe na pasta
        path=$date'/'$filename
        if [ ! -f $path ]
        then
            # depois copia o arquivo para o diretorio
            $(cp -u -f $i $date)
        fi
    done
}

# pega o primeiro param do terminal
param=$1
if [[ $param == '-t' ]]
then 
    organizeByType
elif [[ $param == '-n' ]]
then
    organizeByName
elif [[ $param == '-d' ]]
then
    organizeByDate
fi
