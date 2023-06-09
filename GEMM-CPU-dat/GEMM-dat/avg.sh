#!/bin/bash 

awk '{ sum = 0; for(i = 4; i <= NF - 2; ++i) { sum += $i}; printf("%d\t%f\n", $1, sum/(NF - 5)); }' "$1" | tr ',' '.' > "$1_AVG"
