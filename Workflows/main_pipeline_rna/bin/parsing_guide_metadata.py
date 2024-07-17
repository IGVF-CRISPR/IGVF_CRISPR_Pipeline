#!/usr/bin/env python

import argparse
import subprocess
import pandas as pd
import numpy as np
import os


def system_call(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    output = result.stdout
    print (output)
    error = result.stderr
    return output, error



def process_reads(yaml_file, modality):
  cmd = f"seqspec info {yaml_file}"
  #print('cmd:', cmd)
  out_reads,out_reads_error  = system_call (cmd)
  out_reads = out_reads.split('\n')
  #print ('out', out_reads)

  np_reads = np.array([i.split('"')[3] for i in out_reads if '"read_id"' in i or '"modality"' in i ]).reshape(-1,2)
  print ('np_reads' , np_reads)
  df_read = pd.DataFrame(np_reads, columns=['read', 'modality'])
  #check in the future if we don't find modality in other fields
  return ','.join(df_read.query(f"modality == '{modality}' ")['read'].to_list())

def extract_whitelist_file(yaml_file):
    with open(yaml_file, 'r') as file:
        for line in file:
            if line.strip().startswith("filename"):
                #return line.strip()
                parts = line.strip().split(":", 1)
                if len(parts) > 1:
                    return parts[1].strip()
    return None

def get_info_from_yaml(modality, yaml_file, directory):

    reads = process_reads(yaml_file, modality)
    print ('reads out', reads)
    cmd = f"seqspec index -m {modality} -t kb -r {reads} {yaml_file}"
    print (cmd)
    output, error = system_call(cmd)

    # process_whitelist
    whitelist = extract_whitelist_file(yaml_file)
    whitelist_path = os.path.join(directory, whitelist)
    print ('whitelist', whitelist)
    print(directory)
    # Print the output and error for debugging
    print("Output:", output)
    print("Error:", error)

    # add columns
    return pd.DataFrame([[modality, output.replace('\n', ''), whitelist_path, directory]], columns=['modality', 'representation',
                                                                                               'barcode_whitelist', 'seqspec_dir'])


def main(modalities, yaml_file, output_file, directory):
    df_list = [get_info_from_yaml(m, yaml_file, directory) for m in modalities]
    pd.concat(df_list).to_csv(output_file, index=False, sep='\t')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process modalities and YAML file")
    parser.add_argument('--modalities', nargs='+', required=True, help="List of modalities")
    parser.add_argument('--yaml_file', required=True, help="Path to the YAML file")
    parser.add_argument('--output_file', required=True, help="Output file path")
    parser.add_argument('--directory', required=True, help="Path to the file directory")
    args = parser.parse_args()

    main(args.modalities, args.yaml_file, args.output_file, args.directory)
