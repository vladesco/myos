#!/bin/bash

make clear
make run

FILE=kernel.bin
DIR=./code

if [[ -f $FILE ]]; then

    echo "succeed"

while RES=$(inotifywait -r -e modify $DIR)
   do make run; done

else 
    echo "script failed"
    make clear
fi