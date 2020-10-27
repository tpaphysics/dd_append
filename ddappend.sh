#! /usr/bin/env sh

if [ $# -lt 1 ]
then
    echo "São necessário dois argumentos!"
    exit 1
fi

size1=$(du -b $1 | cut -f1)
size2=$(du -b $2 | cut -f1)

dir=$1_projeto

if [ ! -d ./$dir ]
then    
    mkdir ./$dir
    cp $1 ./$dir/$1.append
fi

dd if=$2 >> ./$dir/$1.append
size3=$(du -b ./$dir/$1.append | cut -f1)

echo "$1 size: $size1" > ./$dir/$1.log
echo "[*] Tamanho da imagem: $1 --> $size1"
echo "[*] Tamanho do arquivo.bin: $2 --> $size2"
echo "[*] Tamanho final, imagem + arquivo.bin: $1.append --> $size3"
exit 0
