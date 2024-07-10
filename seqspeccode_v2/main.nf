nextflow.enable.dsl=2

include { seqSpecParser as seqSpecParser_rna}    from  './processes/seqSpecParser'
include { seqSpecParser as seqSpecParser_guide}    from  './processes/seqSpecParser'

workflow {
    seqp_out_rna =    seqSpecParser_rna(params.seqSpec_yaml_rna, 'rna')
    seqp_out_guide =    seqSpecParser_guide(params.seqSpec_yaml_guide, 'guide')
}
