import pandas as pd
import numpy as np
import sys

def compute_log10(input_file, output_file):
    data = pd.read_csv(input_file, header=None, names=['Column1', 'Column2'], delimiter='\t')
    
    data['Column2'] = 1000 * data['Column2'] / (data['Column1'] * data['Column1'] + data['Column1'] * data['Column1'] * data['Column1'])
    # Compute log10 of values in the second column
    data['Column2_Log10'] = np.log2(data['Column2'])
    
    # Save the computed log10 values to a new file
    data.to_csv(output_file, columns=['Column1', 'Column2_Log10'], sep='\t', index=False, header=False)  # Adjust separator if needed

# Replace 'input_file.txt' and 'output_file.txt' with your file names
compute_log10(sys.argv[1], sys.argv[1] + '.log10')
