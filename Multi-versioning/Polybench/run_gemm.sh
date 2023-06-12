#!/bin/bash

#codes=("linear-algebra/blas/gemm8/" "linear-algebra/blas/gemm16/" "linear-algebra/blas/gemm/" "linear-algebra/blas/gemm64/" "linear-algebra/blas/gemm128/")
codes=("linear-algebra/blas/gemm_intratile_8_128_8-16_2_16/")

vals=(100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3100 3200 3300 3400 3500)

echo "" > bench_gemm
for code in ${codes[@]}; do
	for val in ${vals[@]}; do
		echo "$code, $val"
		gcc -O3 -fopenmp -I utilities -I linear-algebra/blas/gemm utilities/polybench.c $code/gemm.pluto.c -DPOLYBENCH_TIME -DPOLYBENCH_CYCLE_ACCURATE_TIMER -DPOLYBENCH_USE_C99_PROTO -DNI=$val -DNJ=$val -DNK=$val -o output
		
		echo "" > _tmp_result
		for i in $(seq 1 20); do
			res=`./output`
			echo $res >> _tmp_result
		done
		
		results=`sort -g _tmp_result | paste -s -d "\t"`
		
		echo "$val	$results" >> bench_gemm
	done
done
	
