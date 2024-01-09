import pandas as pd
import sys

def read_csv_files(files):
    data_frames = []
    for file in files:
        try:
            data = pd.read_csv(file, header=0, delimiter='\t')
            data_frames.append(data)
        except Exception as e:
            print(f"Error reading {file}: {e}")
    return data_frames

file_paths = sys.argv[1:]
data_frames = read_csv_files(file_paths)


frame_idx = [0 for _ in data_frames]


for idx, _ in enumerate(data_frames):
    for it, meas in 
    
    
