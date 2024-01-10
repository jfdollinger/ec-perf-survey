import pandas as pd
import numpy as np
import sys


def read_csv_files(files):
  data_frames = []

  for file in files:
    try:
      data = pd.read_csv(file, header=None, delimiter='\t')
      data_frames.append(data)
    except Exception as e:
      print(f"Error reading {file}: {e}")

  return data_frames


def intersection_point(point1_line1, point2_line1, point1_line2, point2_line2):
  # Function to calculate slope and y-intercept given two points
  def line_equation(point1, point2):
    slope = (point2[1] - point1[1]) / (point2[0] - point1[0])
    y_intercept = point1[1] - slope * point1[0]
    return slope, y_intercept

  # Get the equations of the lines
  m1, b1 = line_equation(point1_line1, point2_line1)
  m2, b2 = line_equation(point1_line2, point2_line2)

  # Check if the slopes are equal (parallel lines)
  if m1 == m2:
    if b1 == b2:
      return "Infinite intersections (same line)"
    else:
      return "No intersection (parallel lines)"

  # Calculate x-coordinate of intersection
  x_intersection = (b2 - b1) / (m1 - m2)

  # Calculate y-coordinate of intersection using one of the lines
  y_intersection = m1 * x_intersection + b1

  return x_intersection, y_intersection


if len(sys.argv) < 1:
  print("No files provided")
  sys.exit(1)

files = sys.argv[1:]
data_frames = read_csv_files(files)

vals = {}
for idx, data_frame in enumerate(data_frames):
  prev_tuple = None
  for pb_size, exec_time in data_frame.values:
    curr_tuple = (pb_size, exec_time)
    data_tuple = {'id': idx, 'curr': curr_tuple, 'prev': prev_tuple}
    if pb_size in vals:
      vals[pb_size].append(data_tuple)
    else:
      vals[pb_size] = [data_tuple]

    prev_tuple = curr_tuple

auxiliary = {}
prev_min_tuple = None

dict_tuples = list(vals.items())
for idx, (_, data_list) in enumerate(dict_tuples):
  min_tuple = min(data_list,
                       key=lambda data_element: data_element['curr'][1])
  min_tuple_id = min_tuple['id']

  m4, b4 = min_tuple['curr']
  
  if prev_min_tuple is not None:
    prev_tuple_id = prev_min_tuple['id']
    if min_tuple_id != prev_tuple_id:
      prev_next_tuple_id = prev_min_tuple['id']
      
      prev_next_tuple = None
      for _, next_data_list in dict_tuples[idx:]:
        prev_next_tuple = next((prev_next_tuple for prev_next_tuple in next_data_list
                                if prev_next_tuple['id'] == prev_next_tuple_id), None)
        if prev_next_tuple is not None:
          break
      
      if prev_next_tuple is not None:
        prev_tuple = min_tuple['prev']
        
        m1, b1 = prev_min_tuple['curr']
        m2, b2 = prev_next_tuple['curr']
        m3, b3 = prev_tuple

        x, y = intersection_point((m1, b1), (m2, b2), (m3, b3), (m4, b4))
        print(f"{x}\t{y}")
        
        version_exec_time = [float('inf')] * len(data_frames)
        version_exec_time[prev_tuple_id] = y
        version_exec_time[min_tuple_id] = y

        auxiliary[x] = version_exec_time
      else:
        print("Houston, got a problem here !")
        sys.exit(1)

  prev_min_tuple = min_tuple

  print(f"{m4}\t{b4}")
  
  version_exec_time = [float('inf')] * len(data_frames)
  version_exec_time[min_tuple_id] = b4
  
  auxiliary[m4] = version_exec_time
  


auxiliary_df = pd.DataFrame.from_dict(auxiliary, orient='index')
auxiliary_df.to_csv('aux_output', header=False, sep='\t')
  
