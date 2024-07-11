nextflow.enable.dsl=2

include { mappingscRNA } from './processes/kb_mapping'

workflow {
  map_rna = mappingscRNA(
        params.out_name_dir,
        tuple(file("${params.MappingDirectory}/${params.fastq_file1}"), file("${params.MappingDirectory}/${params.fastq_file2}")),
        file("${params.MappingDirectory}/${params.transcriptome_idx}"),
        file("${params.MappingDirectory}/${params.transcriptome_t2g}"),
        file("${params.MappingDirectory}/${params.parsed_seqSpec_file}"),
        file("${params.MappingDirectory}/${params.whitelist}")
     )
}
