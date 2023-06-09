#!/bin/bash 

awk '{ sum = 0; for(i = 6; i <= NF - 4; ++i) { sum += $i}; printf("%d\t%f\n", $1, sum/(NF - 9)); }' "$1" | tr ',' '.' > "$1_AVG"
