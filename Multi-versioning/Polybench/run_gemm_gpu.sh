#!/bin/bash


#"data13" using 1:($2/1000) with linespoints title "tile-size = 8x8x8, block-size = 8x8",\
#"data21" using 1:($2/1000) with linespoints title "tile-size = 16x16x16, block-size = 8x8",\
#"data22" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 8x8",\
#"data23" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 8x8",\
#"data24" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 8x8",\
#"data14" using 1:($2/1000) with linespoints title "tile-size = 16x16x16, block-size = 16x16",\
#"data09" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 16x16",\
#"data07" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 16x16",\
#"data25" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 16x16",\
#"data12" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 32x32",\
#"data10" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 32x32",\
#"data01" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 32x32"


#codes=("linear-algebra/blas/gemm_128_128_128-32_32/" "linear-algebra/blas/gemm_128_16_16-16_16/" "linear-algebra/blas/gemm_256_32_32-32_32/" "linear-algebra/blas/gemm_64_64_32-32_32/" "linear-algebra/blas/gemm_128_32_32-32_32/" "linear-algebra/blas/gemm_32_16_16-32_16/" "linear-algebra/blas/gemm_64_64_64-16_16/" "linear-algebra/blas/gemm_128_64_16-16_16/" "linear-algebra/blas/gemm_32_32_32-16_16/" "linear-algebra/blas/gemm64_64_64-32_32/" "linear-algebra/blas/gemm_128_64_32-32_32/" "linear-algebra/blas/gemm_32_32_32-32_32/" "linear-algebra/blas/gemm8_8_8-8_8/" "linear-algebra/blas/gemm16_16_16-16_16/" "linear-algebra/blas/gemm_32_32_64-32_32/")

codes=("linear-algebra/blas/gemm8_8_8-8_8/" "linear-algebra/blas/gemm16_16_16-8_8/" "linear-algebra/blas/gemm32_32_32-8_8/" "linear-algebra/blas/gemm64_64_64-8_8/" "linear-algebra/blas/gemm128_128_128-8_8/" "linear-algebra/blas/gemm16_16_16-16_16/" "linear-algebra/blas/gemm_32_32_32-16_16/" "linear-algebra/blas/gemm_64_64_64-16_16/" "linear-algebra/blas/gemm_128_128_128-16_16/" "linear-algebra/blas/gemm_32_32_32-32_32/" "linear-algebra/blas/gemm64_64_64-32_32/" "linear-algebra/blas/gemm_128_128_128-32_32/")

vals=(100 150 200 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3100 3200 3300 3400 3500)

echo "" > bench_gemm_gpu
for code in ${codes[@]}; do
	for val in ${vals[@]}; do
		echo "$code, $val"
		nvcc -O3 -arch=sm_86 -I utilities -I linear-algebra/blas/gemm utilities/polybench.cpp $code/gemm_host.cu $code/gemm_kernel.cu -DPOLYBENCH_TIME -DPOLYBENCH_CYCLE_ACCURATE_TIMER -DNI=$val -DNJ=$val -DNK=$val -o output || exit -1
		
		echo "" > _tmp_result
		for i in $(seq 1 20); do
			res=`./output`
			echo $res >> _tmp_result
		done
		
		results=`sort -g _tmp_result | paste -s -d "\t"`
		
		echo "$val	$results" >> bench_gemm_gpu
	done
done
	
