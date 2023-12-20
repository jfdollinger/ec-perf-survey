set terminal postscript eps enhanced color font 'Helvetica, 12'
set output 'rtt.eps'

#set title "Cumulative distribution of latency over different network configurations"
set xlabel "Latency (RTT in ms)"
set ylabel "Cumulative probability"

set key top right
#set logscale y
set logscale x

# Set the range of the x-axis and y-axis
#set xrange [0:1.5]

# Plot the data for each curve
plot "rtt_b2_wifi.cumul.dat" using 1:2 with linespoint pt 4 linewidth 3 title "Wifi (indoor)",\
     "rtt_b2_4g+.cumul.dat" using 1:2 with linespoint pt 2 linewidth 3 title "4G+ (indoor)",\
     "rtt_b2_wifi.cumul.norm.dat" using 1:2 with linespoint pt 4 linewidth 3 title "Wifi (indoor, normalized)",\
     "rtt_b2_4g+.cumul.norm.dat" using 1:2 with linespoint pt 2 linewidth 3 title "4G+ (indoor, normalized)"

#     "network.ping.kvm.int.cumul.dat" using 1:2 with linespoint pt 3 linewidth 3 linecolor rgb "light-green" title "KVM priv.",\
#     "network.ping.tcg.ext.cumul.dat" using 1:2 with linespoint pt 13 linewidth 3 linecolor rgb "blue" title "TCG pub.-priv.",\
#     "network.ping.tcg.int.cumul.dat" using 1:2 with linespoint pt 12 linewidth 3 linecolor rgb "light-blue" title "TCG priv.",\
#     "network.ping.con.ext.cumul.dat" using 1:2 with linespoint pt 7 linewidth 3 linecolor rgb "light-red" title "Docker pub.-priv.",\
#     "network.ping.con.int.cumul.dat" using 1:2 with linespoint pt 6 linewidth 3 linecolor rgb "light-pink" title "Docker priv."

     

     
