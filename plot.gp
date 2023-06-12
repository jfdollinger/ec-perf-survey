set terminal eps
set output 'output.eps'

set title "Execution Time vs. Stride"
set xlabel "Stride"
set ylabel "Execution Time"

set key top left

# Set the range of the x-axis and y-axis
set xrange [0:100]
set yrange [0:10]

# Set the line style and color for each curve
set style line 1 lt 1 lw 2 lc rgb "red"
set style line 2 lt 1 lw 2 lc rgb "blue"
set style line 3 lt 1 lw 2 lc rgb "green"

# Plot the data for each curve
plot "data1.dat" using 1:2 with lines title "Thread 1" ls 1,\
     "data2.dat" using 1:2 with lines title "Thread 2" ls 2,\
     "data3.dat" using 1:2 with lines title "Thread 3" ls 3