
nextflow.enable.dsl=2

include { seqSpecParser } from './processes/seqSpecParser.nf'
include { downloadReference } from './processes/downloadReference.nf'
include { mappingscRNA } from './processes/mappingscRNA.nf'

workflow mapping_rna_pipeline {

    seqSpecResult = seqSpecParser(
        file("${params.seqSpecDirectory}/${params.seqSpec_yaml_rna}"),
        file(params.seqSpecDirectory),
        'rna')

    downloadRefResult = downloadReference(
        params.TRANSCRIPTOME_REFERENCE
    )

    MappingOut = mappingscRNA(
        file(params.fastq_files_rna),
        tuple(params.fastq_file1_rna, params.fastq_file2_rna),
        downloadRefResult.transcriptome_idx,
        downloadRefResult.t2g_transcriptome_index,
        seqSpecResult.parsed_seqspec,
        seqSpecResult.whitelist)
}
