
process mappingGuide {
    cache 'lenient'
    cpus 6
    debug true
    conda "./conda_envs/kallisto_ref.yaml"

    input:
    path fastq_files
    tuple val(fastq_file1), val(fastq_file2)
    path guide_index
    path t2guide
    path parsed_seqSpec_file
    path whitelist

    output:
    path("ks_guide_out"), emit: ks_guide_out
    path("ks_guide_out/counts_unfiltered/adata.h5ad"), emit: ks_guide_out_adata_h5ad

    script:
        """
        k_bin=\$(which kallisto)
        chemistry=\$(extract_parsed_seqspec.py --file ${parsed_seqSpec_file})
        reads=\$(process_reads.py --dir ${fastq_files} --reads1 '${fastq_file1}' --reads2 '${fastq_file2}')
        kb count -i ${guide_index} -g ${t2guide} --verbose -w ${whitelist} --h5ad --kallisto \$k_bin -x \$chemistry -o ks_guide_out -t ${task.cpus} \$reads --overwrite -m 30G
        """
}
