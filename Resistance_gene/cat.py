#here is the scripts:
import pandas as pd
import os

# Get a list of all Excel files in the current directory
excel_files = [f for f in os.listdir('.') if f.endswith('.xlsx')]

# Read each Excel file and store them in a list
dfs = [pd.read_excel(f) for f in excel_files]

# Add a new column with the file name
for i, df in enumerate(dfs):
    base = os.path.splitext(excel_files[i])[0]
    df['File'] = base

# Concatenate all DataFrames
combined_df = pd.concat(dfs, ignore_index=True)

# Save the combined DataFrame to a new Excel file
combined_df.to_excel('combined.xlsx', index=False)

