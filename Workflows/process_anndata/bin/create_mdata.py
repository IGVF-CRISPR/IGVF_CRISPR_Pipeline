#!/usr/bin/env python

import argparse
import muon as mu
import anndata as ad
import pandas as pd
import numpy as np
from muon import MuData
import matplotlib.pyplot as plt

def main(adata_rna, adata_guide, guide_metadata):
    # Load the guide metadata
    guide_metadata = pd.read_excel(guide_metadata)
    guide_metadata['sgRNA_ID|sequence'] = guide_metadata['sgRNA_ID'] + "|" + guide_metadata['sgRNA_sequences']

    adata_rna = ad.read_h5ad(adata_rna)
    adata_guide = ad.read_h5ad(adata_guide)
    adata_guide.var_names = guide_metadata['sgRNA_ID|sequence']

    # adding number of nonzero guides and batch number
    adata_guide.obs["number_of_nonzero_guides"] = (adata_guide.X > 0).sum(axis=1)
    adata_guide.obs["batch_number"] = 1

    # knee plots
    knee_df = pd.DataFrame({
        'sum': np.array(adata_guide.X.sum(1)).flatten(),
        'barcodes': adata_guide.obs_names.values})
    knee_df = knee_df.sort_values('sum', ascending=False).reset_index(drop=True)
    knee_df['sum_log'] = np.log1p(knee_df['sum'])

    plt.figure(figsize=(8, 5))
    plt.plot(knee_df.index, knee_df['sum_log'], marker='o', linestyle='-', markersize=3)
    plt.xlabel('Barcode Index')
    plt.ylabel('Log of UMI Counts')
    plt.title('Knee Plot')

    # Save knee plot
    plt.savefig('knee_plot_guide.png')


    # Find the intersection of barcodes between scRNA and guide data
    intersecting_barcodes = list(set(adata_rna.obs_names).intersection(adata_guide.obs_names))

    mdata = MuData({
        'transcripts': adata_rna[intersecting_barcodes, :].copy(),
        'guides': adata_guide[intersecting_barcodes, :].copy()
    })

    # Save the MuData object
    mdata.write("mudata.h5mu")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Create a MuData object from scRNA and guide data.')
    parser.add_argument('adata_rna', type=str, help='Path to the scRNA AnnData file.')
    parser.add_argument('adata_guide', type=str, help='Path to the guide AnnData file.')
    parser.add_argument('guide_metadata', type=str, help='Path to the guide metadata Excel file.')

    args = parser.parse_args()
    main(args.adata_rna, args.adata_guide, args.guide_metadata)
