set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'output.eps'

#set title "Execution time of parallel and tiled gemm on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time (ms)"

set key top left
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
#set yrange [0:10]



# Plot the data for each curve
plot "data_v1.dat" using 1:2 with linespoints title "tile-size = 8x8x8, v1",\
     "data_v2.dat" using 1:2 with linespoints title "tile-size = 16x16x16, v2",\
     "data_v3.dat" using 1:2 with linespoints title "tile-size = 32x32x32, v3",\
     "data_v4.dat" using 1:2 with linespoints title "tile-size = 64x64x64, v4",\
     "data_v5.dat" using 1:2 with linespoints title "tile-size = 128x128x128, V5",\
     "data_v6.dat" using 1:2 with linespoints title "tile-size = 8x8x8, intra-tiling = 16x16x16, v6",\
     "data_v7.dat" using 1:2 with linespoints title "tile-size = 16x16x16, intra-tiling = 32x32x32, v7",\
     "data_v8.dat" using 1:2 with linespoints title "tile-size = 32x32x32, intra-tiling = 32x32x32, v8",\
     "data_v9.dat" using 1:2 with linespoints title "tile-size = 8x128x8, intra-tiling = 16x2x16, v9"
     

     
