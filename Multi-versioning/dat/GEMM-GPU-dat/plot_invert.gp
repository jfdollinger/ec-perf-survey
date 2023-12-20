set terminal postscript eps enhanced color font 'Helvetica, 10'
set output 'output_invert.eps'

#set title "Execution time of parallel and tiled versions of GEMM on NVIDIA A40-2Q"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time (ms)"

set key top right
set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:3500]
#set yrange [0:0.1]

f(x) = a1 * log(x) + b1
g(x) = a2 * log(x) + b2
h(x) = a3 * log(x) + b3
i(x) = a4 * log(x) + b4
k(x) = a5 * log(x) + b5

fit f(x) 'data_v11' every ::0::2 using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) via a1, b1
fit g(x) 'data_v11' every ::0::4 using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) via a2, b2
fit h(x) 'data_v11' every ::0::8 using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) via a3, b3
fit i(x) 'data_v11' every ::0::16 using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) via a4, b4
fit k(x) 'data_v11' every ::0::32 using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) via a5, b5

# Plot the data for each curve
plot "data_v11" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 8x8x8, block-size = 8x8, v10",\
    f(x) title 'Logarithmic Fit 2',\
    g(x) title 'Logarithmic Fit 4',\
    h(x) title 'Logarithmic Fit 8',\
    i(x) title 'Logarithmic Fit 16',\
    k(x) title 'Logarithmic Fit 32'
     #"data_v11" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 16x16x16, block-size = 8x8, v11",\
     #"data_v12" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 32x32x32, block-size = 8x8, v12",\
     #"data_v13" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 64x64x64, block-size = 8x8, v13",\
     #"data_v14" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 128x128x128, block-size = 8x8, v14",\
     #"data_v15" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 16x16x16, block-size = 16x16, v15",\
     #"data_v16" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 32x32x32, block-size = 16x16, v16",\
     #"data_v17" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 64x64x64, block-size = 16x16, v17",\
     #"data_v18" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 128x128x128, block-size = 16x16, v18",\
     #"data_v19" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 32x32x32, block-size = 32x32, v19",\
     #"data_v20" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 64x64x64, block-size = 32x32, V20",\
     #"data_v21" using 1:(1 / ($2 / ($1 * $1 + $1 * $1 * $1))) with linespoints title "tile-size = 128x128x128, block-size = 32x32, v21",\
     
     
     

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


     
