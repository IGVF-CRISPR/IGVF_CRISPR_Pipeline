#!/usr/bin/env python

import pandas as pd
import argparse
import glob
import os

def process_files(directory):
    file_path = os.path.join(directory, 'rna_parsed_seqSpec.txt')
    if not os.path.isfile(file_path):
        print("Cannot find the parsed_seqspec file")
        return None

    df = pd.read_csv(file_path, sep='\t')
    return ''.join(df['representation'].astype(str))

def main():
    parser = argparse.ArgumentParser(description="Process parsed_seqspec files and extract seqspec info")
    parser.add_argument('--directory', required=True, help="Directory containing the file.")
    
    args = parser.parse_args()
    
    result = process_files(args.directory)
    if result:
        print(result)

if __name__ == "__main__":
    main()
