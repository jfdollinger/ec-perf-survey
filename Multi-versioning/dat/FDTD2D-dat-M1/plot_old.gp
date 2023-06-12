set terminal postscript eps enhanced color font 'Helvetica, 10'
set output 'output.eps'

set title "Execution time of parallel and tiled fdtd-2d on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Problem size"
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
plot "data1.dat" using 1:2 with lines title "fdtd-2d, tile-size = 8x8x8" ls 1,\
     "data2.dat" using 1:2 with lines title "fdtd-2d, tile-size = 16x16x16" ls 2,\
     "data3.dat" using 1:2 with lines title "fdtd-2d, tile-size = 32x32x32" ls 3,\
     "data4.dat" using 1:2 with lines title "fdtd-2d, tile-size = 64x64x64" ls 4,\
     "data5.dat" using 1:2 with lines title "fdtd-2d, tile-size = 128x128x128" ls 5
     

     
