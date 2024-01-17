set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'dolli11.eps'

#set title "Execution time of parallel and tiled fdtd-2d on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Problem size (TMAX = NX = NY)"
set ylabel "Execution time (log10(ps))"

set key top right
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
set yrange [0.5:5]


# Plot the data for each curve
plot 'aux_output' using 1:2 with filledcurves y = 1 lc "dark-khaki" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:3 with filledcurves y = 1 lc "green" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:4 with filledcurves y = 1 lc "blue" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:5 with filledcurves y = 1 lc "orange" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:6 with filledcurves y = 1 lc "yellow" fs transparent solid 0.2 notitle,\
     "data_v1.dat.log10" using 1:2 with linespoints pt 1 lc "dark-khaki" title "tile-size = 8x8x8, v1",\
     "data_v2.dat.log10" using 1:2 with linespoints pt 2 lc "green" title "tile-size = 16x16x16, v2",\
     "data_v3.dat.log10" using 1:2 with linespoints pt 3 lc "blue" title "tile-size = 32x32x32, v3",\
     "data_v4.dat.log10" using 1:2 with linespoints pt 4 lc "orange" title "tile-size = 64x64x64, v4",\
     "data_v5.dat.log10" using 1:2 with linespoints pt 5 lc "yellow" title "tile-size = 128x128x128, v5",\
     "minimal.dat.log10" using 1:2 with lines dt 0 lw 3 lc "black" title "minimal execution time"
     
