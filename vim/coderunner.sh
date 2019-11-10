#!/usr/bin/bash

FILE=$2"."$1
clear
if [ "$1" = "c" ]; then
    gcc $FILE -lm && ./a.out
elif [ "$1" = "cpp" ]; then
    g++ $FILE -lm && ./a.out
elif [ "$1" = "java" ]; then
    javac $FILE && java $2
elif [ "$1" = "py" ]; then
    python $FILE
else
    echo "Unsupported language!"
fi

