set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'output_best_selected_versions.eps'

#set title "Execution time of parallel and tiled gemm on M1, M2 and GPU"
set xlabel "Problem size (NI = NJ = NK)"
set ylabel "Execution time per iteration (ns)"

set key top right
set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
#set yrange [0:10]

set style fill transparent

# Plot the data for each curve
plot "courbe_minimal_GEMM-CPU-M1.dat" using 1:($2 / ($1 * $1 + $1 * $1 * $1)) with linespoints title "ideal execution time - M1",\
     "courbe_minimal_GEMM-CPU-M2.dat" using 1:($2 / ($1 * $1 + $1 * $1 * $1)) with linespoints title "ideal execution time - M2",\
     "courbe_minimal_GEMM-GPU.dat" using 1:($2 / ($1 * $1 + $1 * $1 * $1)) with linespoints title "ideal execution time - GPU"
     #"courbe_minimal.dat" using 1:($2 / ($1 * $1 + $1 * $1 * $1)) with lines lw 4 lc "black" title "minimal execution time"
 
 
# lw 4 dashtype 2 lc "salmon"
     

     
