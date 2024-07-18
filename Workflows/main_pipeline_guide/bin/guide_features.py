#!/usr/bin/env python

import pandas as pd
import argparse

def process_table(guide_table):
    guide_metadata = pd.read_excel(guide_table, header=0)
    guide_metadata[['sgRNA_sequences', 'sgRNA_ID']].to_csv('guide_features.txt',
                                                           sep='\t', header=None, index=None)

def main():
    parser = argparse.ArgumentParser(description="Process guide metadata.")
    parser.add_argument('--guide_table', type=str, required=True, help="Path to the input Guide file.")
    args = parser.parse_args()

    process_table(args.guide_table)

if __name__ == "__main__":
    main()
