set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'output.eps'

#set title "Execution time of parallel and tiled fdtd-2d on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Problem size (TMAX = NX = NY)"
set ylabel "Execution time (ms)"

set key top left
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
#set yrange [0:10]


# Plot the data for each curve
plot "data_v1.dat" using 1:($2/1000)  with linespoints title "tile-size = 8x8x8, v1",\
     "data_v2.dat" using 1:($2/1000)  with linespoints title "tile-size = 16x16x16, v2",\
     "data_v3.dat" using 1:($2/1000)  with linespoints title "tile-size = 32x32x32, v3",\
     "data_v4.dat" using 1:($2/1000)  with linespoints title "tile-size = 64x64x64, v4",\
     "data_v5.dat" using 1:($2/1000)  with linespoints title "tile-size = 128x128x128, v5"
     

     
