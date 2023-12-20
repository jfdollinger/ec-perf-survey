set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'output.eps'

#set title "Execution time of parallel and tiled versions of FDTD-2D on NVIDIA A40-2Q"
set xlabel "Problem size (TMAX = NX = NY)"
set ylabel "Execution time (ms)"

set key top right
set logscale y
#set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:100]
#set yrange [0:10]

# Plot the data for each curve
plot "data_v10" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 8x8x8, block-size = 8x8, v10",\
"data_v11" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 16x16x16, block-size = 8x8, v11",\
"data_v12" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 32x32x32, block-size = 8x8, v12",\
"data_v13" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 64x64x64, block-size = 8x8, v13",\
"data_v14" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 128x128x128, block-size = 8x8, v14",\
"data_v15" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 16x16x16, block-size = 16x16, v15",\
"data_v16" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 32x32x32, block-size = 16x16, v16",\
"data_v17" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 64x64x64, block-size = 16x16, v17",\
"data_v18" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 128x128x128, block-size = 16x16, v18",\
"data_v19" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 32x32x32, block-size = 32x32, v19",\
"data_v20" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 64x64x64, block-size = 32x32, v20"
#"data1.dat" using 1:($2 / ($1 * ($1 + 2 * $1 * ($1 - 1) + ($1 - 1) * ($1 - 1))))  with linespoints title "tile-size = 128x128x128, block-size = 32x32, v21",\

#"stencils/fdtd-2d_128_128_128-32_32/" 
#"stencils/fdtd-2d_32_32_32-32_32/" 
#"stencils/fdtd-2d_8_8_8-8_8/" 
#"stencils/fdtd-2d_16_16_16-16_16/" 
#"stencils/fdtd-2d_32_32_64-32_32/" 
#"stencils/fdtd-2d32_16_16-32_16/" 
#"stencils/fdtd-2d_32_64_64-32_32/"
     
#     "stencils/fdtd-2d_16_16_16-8_8/" 
#     "stencils/fdtd-2d_32_32_32-8_8/" 
#     "stencils/fdtd-2d_32_32_32-16_16/" 
#     "stencils/fdtd-2d_64_64_64-8_8/" 
#     "stencils/fdtd-2d_64_64_64-16_16/" 
#     "stencils/fdtd-2d_64_64_64-32_32/" 
#     "stencils/fdtd-2d_128_128_128-8_8/" 
#     "stencils/fdtd-2d_128_128_128-16_16/"
