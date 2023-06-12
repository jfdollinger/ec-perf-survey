set terminal postscript eps enhanced color font 'Helvetica, 10'
set output 'output.eps'

set title "Highlighting CPU cache false-sharing effect on Intel(R) Xeon(R) CPU E3-1260L v5"
set xlabel "Memory access stride (bytes)"
set ylabel "Execution time (ms)"

set key top right
set xtics nomirror
set ytics nomirror

set xtics 5

set style line 81 lt 0 lc rgb "#808080" lw 0.5
#set grid xtics
#set grid ytics
#set grid back ls 81


# Set the range of the x-axis and y-axis
set xrange [0:85]
#set yrange [0:10]

# Set the line style and color for each curve
set style line 1 lt 1 lw 3 pt 5 ps 1.5 lc rgb "red" 
set style line 2 lt 1 lw 3 pt 7 ps 1.5 lc rgb "blue"
set style line 3 lt 1 lw 3 pt 2 ps 1.5 lc rgb "green"

# Plot the data for each curve
plot "data1.dat" using ($1*2):($2 / 1000000) with linespoints title "2 threads" ls 1,\
     "data2.dat" using ($1*2):($2 / 1000000) with linespoints title "4 threads" ls 2,\
     "data3.dat" using ($1*2):($2 / 1000000) with linespoints title "8 threads" ls 3
