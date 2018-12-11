#!/bin/bash

if [ -z $1 ]; then
	TEX=`ls -rt | grep .tex | awk '{split($0,a,"."); print a[1]}' | tail -n 1`
else
	TEX=`ls -rt | grep $1 | grep .tex | awk '{split($0,a,"."); print a[1]}' | tail -n 1`
fi

if [ "$TEX" = "" ]; then
	echo "Versao $1 nao encontrada!"
	exit 2
fi

echo "TEX = $TEX" > Makefile
echo "OUTPUT = $TEX" >> Makefile
cat Makefile_base.txt >> Makefile

make
