import sys
import numpy as np
import pandas as pd

filename=sys.argv[1]
col=sys.argv[2]

# Assuming you have a DataFrame 'measurements' with columns: 'x', 'y', 'rtt'
# 'x' and 'y' are indoor coordinates, 'rtt' is the round-trip time measurement
data = pd.read_csv(filename, sep=',')

# Define the size of each square in the grid (e.g., 1 meter)
square_size = 1  # in meters

# Calculate the maximum x and y coordinates to create the grid
max_x = data['x'].max()
max_y = data['y'].max()

min_x = data['x'].min()
min_y = data['y'].min()

# Create grid boundaries based on the maximum x and y coordinates
x_grid = np.arange(min_x, max_x, square_size)
y_grid = np.arange(min_y, max_y, square_size)

# Assign each measurement to a grid square
data['x_grid'] = np.digitize(data['x'], x_grid)
data['y_grid'] = np.digitize(data['y'], y_grid)

# Group measurements by grid squares and calculate average rtt per square
average_rtt_per_square = data.groupby(['x_grid', 'y_grid'])[col].mean().reset_index()

# Display or export the average rtt per square
with pd.option_context('display.max_rows', None):
    print(average_rtt_per_square)
# You can export it to a CSV file using: average_rtt_per_square.to_csv('average_rtt_per_square.csv', index=False)

