#! /usr/bin/env sh

if [ $# -lt 1 ]
then
    echo "São necessário dois argumentos!"
    exit 1
fi

original_size=$(cat $2 | cut -d " " -f3)
dd if=$1 skip=$original_size ibs=1 of=$1.out
chmod +x $1.out
exit 0   
