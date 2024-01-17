set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'dolli12.eps'

#set title "Execution time of parallel and tiled versions of FDTD-2D on NVIDIA A40-2Q"
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
    'aux_output' using 1:7 with filledcurves y = 1 lc "dark-blue" fs transparent solid 0.2 notitle,\
    'aux_output' using 1:8 with filledcurves y = 1 lc "red" fs transparent solid 0.2 notitle,\
    'aux_output' using 1:9 with filledcurves y = 1 lc "salmon" fs transparent solid 0.2 notitle,\
    'aux_output' using 1:10 with filledcurves y = 1 lc "violet" fs transparent solid 0.2 notitle,\
    'aux_output' using 1:11 with filledcurves y = 1 lc "dark-olivegreen" fs transparent solid 0.2 notitle,\
    'aux_output' using 1:12 with filledcurves y = 1 lc "light-blue" fs transparent solid 0.2 notitle,\
    "data_v10.dat.log10" using 1:2 with linespoints pt 1 lc "dark-khaki" title "tile-size = 8x8x8, block-size = 8x8, v10",\
    "data_v11.dat.log10" using 1:2 with linespoints pt 2 lc "green" title "tile-size = 16x16x16, block-size = 8x8, v11",\
    "data_v12.dat.log10" using 1:2 with linespoints pt 3 lc "blue" title "tile-size = 32x32x32, block-size = 8x8, v12",\
    "data_v13.dat.log10" using 1:2 with linespoints pt 4 lc "orange" title "tile-size = 64x64x64, block-size = 8x8, v13",\
    "data_v14.dat.log10" using 1:2 with linespoints pt 5 lc "yellow" title "tile-size = 128x128x128, block-size = 8x8, v14",\
    "data_v15.dat.log10" using 1:2 with linespoints pt 6 lc "dark-blue" title "tile-size = 16x16x16, block-size = 16x16, v15",\
    "data_v16.dat.log10" using 1:2 with linespoints pt 7 lc "red" title "tile-size = 32x32x32, block-size = 16x16, v16",\
    "data_v17.dat.log10" using 1:2 with linespoints pt 8 lc "salmon" title "tile-size = 64x64x64, block-size = 16x16, v17",\
    "data_v18.dat.log10" using 1:2 with linespoints pt 9 lc "violet" title "tile-size = 128x128x128, block-size = 16x16, v18",\
    "data_v19.dat.log10" using 1:2 with linespoints pt 10 lc "dark-olivegreen" title "tile-size = 32x32x32, block-size = 32x32, v19",\
    "data_v20.dat.log10" using 1:2 with linespoints pt 11 lc "light-blue" title "tile-size = 64x64x64, block-size = 32x32, v20",\
    "minimal.dat.log10" using 1:2 with lines dt 0 lw 3 lc "black" title "minimal execution time"
#"data1.dat" using 1:2  with linespoints title "tile-size = 128x128x128, block-size = 32x32, v21",\

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
