nextflow.enable.dsl=2

include { seqSpecParser } from './processes/seqSpecParser.nf'
include { downloadReference } from './processes/ref_download.nf'
include { mappingscRNA } from './processes/kb_mapping.nf'

workflow {

    seqSpecResult = seqSpecParser(
        file("${params.seqSpecDirectory}/${params.seqSpec_yaml_rna}"),
        file(params.seqSpecDirectory),
        'rna'
    )

    downloadRefResult = downloadReference(
        params.TRANSCRIPTOME_REFERENCE
    )

    MappingOut = mappingscRNA(
        tuple(file(params.fastq_file1), file(params.fastq_file2)),
        downloadRefResult.transcriptome_idx,
        downloadRefResult.t2g_transcriptome_index,
        seqSpecResult.parsed_seqspec,
        file(params.whitelist)
    )
}
