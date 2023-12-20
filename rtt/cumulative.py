#!/bin/python3

import sys
import numpy as np

if len(sys.argv) != 2:
	exit(-1)

# Read the data file with RTT measurements
data_file = sys.argv[1]

rtt_data = np.loadtxt(data_file)

# Sort the RTT measurements in ascending order
sorted_rtt = np.sort(rtt_data)

hist, bin_edge = np.histogram(rtt_data, bins='auto');
hist_cumsum = np.cumsum(hist) / len(sorted_rtt);

for rtt, cdf in zip(bin_edge[1:], hist_cumsum):
	print(f"{rtt} {cdf}")
