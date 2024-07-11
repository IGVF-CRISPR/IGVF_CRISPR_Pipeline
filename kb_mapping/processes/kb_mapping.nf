process mappingscRNA {
    cache 'lenient'
    cpus 1
    debug true
    conda "./conda_envs/kallisto_ref.yaml"

    input:
    val out_name_dir
    tuple path(fastq_file1), path(fastq_file2)
    path transcriptome_idx
    path transcriptome_t2g
    path parsed_seqSpec_file
    path whitelist

    output:
    path("${out_name_dir}_ks_transcripts_out"), emit: ks_transcripts_out
    path("${out_name_dir}_ks_transcripts_out/counts_unfiltered/adata.h5ad"), emit: ks_transcripts_out_adata_h5ad

    script:
        """
        k_bin=\$(which kallisto)
        chemistry=\$(extract_parsed_seqspec.py --file ${parsed_seqSpec_file})
        kb count -i ${transcriptome_idx} -g ${transcriptome_t2g} --verbose -w ${whitelist} --h5ad --kallisto \$k_bin -x \$chemistry -o ${out_name_dir}_ks_transcripts_out -t ${task.cpus} ${fastq_file1} ${fastq_file2} --overwrite -m 48G
        """
}
