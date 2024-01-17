set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'dolli13.eps'

#set title "Execution time of parallel and tiled gemm on M1, M2 and GPU"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time per iteration (ns)"

set key top right
#set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
set yrange [0.5:5.5]

set style fill transparent

plot 'aux_output' using 1:2 with filledcurves y = 1 lc "dark-khaki" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:3 with filledcurves y = 1 lc "green" fs transparent solid 0.2 notitle,\
     'aux_output' using 1:4 with filledcurves y = 1 lc "blue" fs transparent solid 0.2 notitle,\
     "m1.minimal.dat.log10" using 1:2 with linespoints pt 1 lc "dark-khaki" lw 1 title "minimal execution time, M1",\
     "m2.minimal.dat.log10" using 1:2 with linespoints pt 2 lc "green" lw 1 title "minimal execution time, M2",\
     "gpu.minimal.dat.log10" using 1:2 with linespoints pt 3 lc "blue" lw 1 title "minimal execution time, GPU",\
     "minimal.dat.log10" using 1:2 with lines dt 0 lw 3 lc "black" title "minimal execution time"


