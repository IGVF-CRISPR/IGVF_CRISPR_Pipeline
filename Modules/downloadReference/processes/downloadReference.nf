
process downloadReference {
    conda "./conda_envs/kallisto_ref.yaml"
    input:
        val ref_name 
      
    output:
        path "transcriptome_index.idx" , emit: transcriptome_idx
        path "transcriptome_t2g.txt"   , emit: t2g_transcriptome_index
    script:
        """
          k_bin=\$(which kallisto)
          kb ref -d $ref_name -i transcriptome_index.idx -g transcriptome_t2g.txt --kallisto \$k_bin
        """

}
