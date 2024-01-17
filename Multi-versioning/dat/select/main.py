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


def negate(v1):
  a, b = v1

  return (-a, -b)


def to_vector_2d(p1, p2):
  x1, y1 = p1
  x2, y2 = p2

  return (x2 - x1, y2 - y1)


def cross_product_2d(v1, v2):
  a, b = v1
  c, d = v2

  return a * d - b * c


def segment_intersection(s1, s2):
  #a segment is a combination of two tuples of coordinates
  (x1, y1), (x2, y2) = s1
  (x3, y3), (x4, y4) = s2

  v1 = to_vector_2d((x1, y1), (x2, y2))
  v2 = to_vector_2d((x3, y3), (x4, y4))
  v3 = to_vector_2d((x3, y3), (x1, y1))

  det = cross_product_2d(v1, v2)

  if det != 0.0:
    # segments are not parallel
    u = cross_product_2d(v2, v3) / det
    v = cross_product_2d(negate(v3), v1) / det

    if (0.0 <= u <= 1.0) and (0.0 <= v <= 1.0):
      x5, y5 = v1

      return (x1 + u * x5, y1 + u * y5)

  return None


def do_interval_intersect(linterval, rinterval):
  x1, x2 = linterval
  x3, x4 = rinterval

  x1, x2 = (min(x1, x2), max(x1, x2))
  x3, x4 = (min(x3, x4), max(x3, x4))

  return x1 <= x3 and x2 >= x3 or x3 <= x1 and x4 >= x1


#do not forget to add polylines id
def intersect_polyline(lpolyline, rpolyline):
  index = 0
  intersections = []

  for (x1, y1), (x2, y2) in lpolyline:
    offset = 0
    for ((x3, y3), (x4, y4)) in rpolyline[index:]:
      point = segment_intersection(((x1, y1), (x2, y2)), ((x3, y3), (x4, y4)))
      if point is not None:
        intersections.append(point)

      if x4 > x2:  #i.e. not x4 <= x2
        break

      offset = offset + 1

    index = index + offset
    if index == len(rpolyline):
      break
  return intersections


if len(sys.argv) < 1:
  print("No files provided")
  sys.exit(1)

files = sys.argv[1:]
data_frames = read_csv_files(files)

polylines = []
for data_frame in data_frames:
  df_values = data_frame.values

  (x1, y1) = df_values[0]

  segments = []
  for x2, y2 in df_values[1:]:
    segments.append(((x1, y1), (x2, y2)))

    x1, y1 = x2, y2

  polylines.append(segments)

intersections = []
for index, polyline in enumerate(polylines[:len(polylines) - 1]):
  for other_index, other_polyline in enumerate(polylines[index + 1:]):
    #tagging the intersections
    knots = intersect_polyline(polyline, other_polyline)
    knots = [(knot, index, other_index + index + 1) for knot in knots]

    intersections.extend(knots)

for index, data_frame in enumerate(data_frames):
  for pb_size, exec_time in data_frame.values:
    intersections.append(((pb_size, exec_time), index, index))

#double sorting to get the order of the intersections
intersections = sorted(intersections, key=lambda x: x[0][1])
intersections = sorted(intersections, key=lambda x: x[0][0])

#following the first knot leads to the minimal curve
auxiliary = {}
(_, _), _, id2 = intersections[0]
for knot in intersections:
  (pb_size, exec_time), id3, id4 = knot

  if id2 in (id3, id4):
    print(f"{pb_size}\t{exec_time}")
    #aux
    version_exec_time = [float('inf')] * (len(data_frames))
    version_exec_time[id2] = exec_time
  
    id2 = id4 if id2 == id3 else id3
    
    version_exec_time[id2] = exec_time
    auxiliary[pb_size] = version_exec_time
    
auxiliary_df = pd.DataFrame.from_dict(auxiliary, orient='index')
auxiliary_df.to_csv('aux_output', header=False, sep='\t')

