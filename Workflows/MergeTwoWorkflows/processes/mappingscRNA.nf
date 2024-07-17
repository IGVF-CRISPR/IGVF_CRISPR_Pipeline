
process mappingscRNA {
    cache 'lenient'
    cpus 6
    debug true
    conda "./conda_envs/kallisto_ref.yaml"

    input:
    path fastq_files
    tuple val(fastq_file1), val(fastq_file2)
    path transcriptome_idx
    path transcriptome_t2g
    path parsed_seqSpec_file
    path whitelist

    output:
    path("ks_transcripts_out"), emit: ks_transcripts_out
    path("ks_transcripts_out/counts_unfiltered/adata.h5ad"), emit: ks_trans

    script:
        """
        k_bin=\$(which kallisto)
        chemistry=\$(extract_parsed_seqspec.py --file ${parsed_seqSpec_file})
        reads=\$(process_reads.py --dir ${fastq_files} --reads1 '${fastq_file1}' --reads2 '${fastq_file2}')
        kb count -i ${transcriptome_idx} -g ${transcriptome_t2g} --verbose -w ${whitelist} --h5ad --kallisto \$k_bin -x \$chemistry -o ks_transcripts_out -t ${task.cpus} \$reads --overwrite -m 30G
        """
}
