#!/bin/bash

folders=(FDTD2D-dat-GPU FDTD2D-dat-M1 FDTD2D-dat-M2 GEMM-CPU-dat-M1 GEMM-GPU-dat GEMM-CPU-dat-M2)

for folder in ${folders[@]}; do
    (cd "$folder"; python3 main.py data_v*.log10 > minimal.dat.log10; gnuplot plot.gp)
done
