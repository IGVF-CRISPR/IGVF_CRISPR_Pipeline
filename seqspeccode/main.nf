nextflow.enable.dsl=2

include { seqSpecParser }    from  './processes/seqSpecParser'

workflow {
    seqp_out = seqSpecParser(params.seqSpec_yaml, params.modalities )
    seqp_out.parsed_seqspec
}
