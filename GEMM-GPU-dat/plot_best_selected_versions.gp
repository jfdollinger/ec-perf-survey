set terminal postscript eps enhanced color font 'Helvetica, 10'
set output 'output_mini.eps'

#set title "Execution time of parallel and tiled versions of GEMM on NVIDIA A40-2Q"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time (ms)"

set key top left
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
set xrange [0:3500]
#set yrange [100000:1.2e6]

# Set the line style and color for each curve
set style line 1 lt 1 lw 2 lc rgb "red"
set style line 2 lt 1 lw 2 lc rgb "blue"
set style line 3 lt 1 lw 2 lc rgb "yellow"
set style line 4 lt 1 lw 2 lc rgb "brown"
set style line 5 lt 1 lw 2 lc rgb "orange"

# Plot the data for each curve
plot "data_v10" using 1:($2/1000) with linespoints title "tile-size = 8x8x8, block-size = 8x8, v10",\
     "data_v11" using 1:($2/1000) with linespoints title "tile-size = 16x16x16, block-size = 8x8, v11",\
     "data_v12" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 8x8, v12",\
     "data_v13" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 8x8, v13",\
     "data_v14" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 8x8, v14",\
     "data_v15" using 1:($2/1000) with linespoints title "tile-size = 16x16x16, block-size = 16x16, v15",\
     "data_v16" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 16x16, v16",\
     "data_v17" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 16x16, v17",\
     "data_v18" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 16x16, v18",\
     "data_v19" using 1:($2/1000) with linespoints title "tile-size = 32x32x32, block-size = 32x32, v19",\
     "data_v20" using 1:($2/1000) with linespoints title "tile-size = 64x64x64, block-size = 32x32, V20",\
     "data_v21" using 1:($2/1000) with linespoints title "tile-size = 128x128x128, block-size = 32x32, v21",\
     "courbe_minimal_GEMM-GPU.dat" using 1:($2/1000) with linespoints title "Best Selected Versions"
     
     
#REJECTED     
#     "data08" using 1:($2/1000) with linespoints title "tile-size = 128x64x16, block-size = 16x16",\
#     "data02" using 1:($2/1000) with linespoints title "gemm, tile-size = 128x16x16, block-size = 16x16",\
#     "data04" using 1:($2/1000) with linespoints title "gemm, tile-size = 64x64x32, block-size = 32x32",\
#     "data03" using 1:($2/1000) with linespoints title "gemm, tile-size = 256x32x32, block-size = 32x32",\
#     "data05" using 1:($2/1000) with linespoints title "gemm, tile-size = 128x32x32, block-size = 32x32",\
#     "data11" using 1:($2/1000) with linespoints title "gemm, tile-size = 128x64x32, block-size = 32x32",\
#      "data06" using 1:($2/1000) with linespoints title "gemm, tile-size = 32x16x16, block-size = 16x16",\
#     "data15" using 1:($2/1000) with linespoints title "gemm, tile-size = 32x32x64, block-size = 32x32",\

#"linear-algebra/blas/gemm_128_128_128-32_32/" 
#"linear-algebra/blas/gemm_128_16_16-16_16/" 
#"linear-algebra/blas/gemm_256_32_32-32_32/" 
#"linear-algebra/blas/gemm_64_64_32-32_32/" 
#"linear-algebra/blas/gemm_128_32_32-32_32/" 
#"linear-algebra/blas/gemm_32_16_16-32_16/" 
#"linear-algebra/blas/gemm_64_64_64-16_16/" 
#"linear-algebra/blas/gemm_128_64_16-16_16/" 
#"linear-algebra/blas/gemm_32_32_32-16_16/" 
#"linear-algebra/blas/gemm64_64_64-32_32/" 
#"linear-algebra/blas/gemm_128_64_32-32_32/" 
#"linear-algebra/blas/gemm_32_32_32-32_32/" 
#"linear-algebra/blas/gemm8_8_8-8_8/" 
#"linear-algebra/blas/gemm16_16_16-16_16/" 
#"linear-algebra/blas/gemm_32_32_64-32_32/"

#"linear-algebra/blas/gemm16_16_16-8_8/" 
#"linear-algebra/blas/gemm32_32_32-8_8/" 
#"linear-algebra/blas/gemm64_64_64-8_8/" 
#"linear-algebra/blas/gemm128_128_128-8_8/" 
#"linear-algebra/blas/gemm_128_128_128-16_16/"


     
