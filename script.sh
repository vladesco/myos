#!/bin/bash


make clear
make run

FILE=kernel.bin

if [[ -f $FILE ]]; then
    sudo cp $FILE /boot/
    echo "succeed"
else 
    echo "script failed"
    make clear
fi