set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'output_min.eps'

#set title "Execution time of parallel and tiled gemm on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time (ms)"

set key top left
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
#set yrange [0:10]

# Set the line style and color for each curve
set style line 1 lt 1 lw 2 lc rgb "red"
set style line 2 lt 1 lw 2 lc rgb "blue"
set style line 3 lt 1 lw 2 lc rgb "yellow"
set style line 4 lt 1 lw 2 lc rgb "brown"
set style line 5 lt 1 lw 2 lc rgb "orange"

# Plot the data for each curve
plot "data_v1.dat" using 1:2 with linespoints title "gemm, tile-size = 8x8x8",\
     "data_v2.dat" using 1:2 with linespoints title "gemm, tile-size = 16x16x16",\
     "data_v3.dat" using 1:2 with linespoints title "gemm, tile-size = 32x32x32",\
     "data_v4.dat" using 1:2 with linespoints title "gemm, tile-size = 64x64x64",\
     "data_v5.dat" using 1:2 with linespoints title "gemm, tile-size = 128x128x128",\
     "data_v6.dat" using 1:2 with linespoints title "gemm, tile-size = 8x8x8, intra-tiling = 16x16x16",\
     "data_v7.dat" using 1:2 with linespoints title "gemm, tile-size = 16x16x16, intra-tiling = 32x32x32",\
     "data_v8.dat" using 1:2 with linespoints title "gemm, tile-size = 32x32x32, intra-tiling = 32x32x32",\
     "data_v9.dat" using 1:2 with linespoints title "gemm, tile-size = 8x128x8, intra-tiling = 16x2x16",\
     "courbe_minimal_GEMM-CPU-Num.dat" using 1:2 with linespoints title "Best Selected Versions"
     

     
