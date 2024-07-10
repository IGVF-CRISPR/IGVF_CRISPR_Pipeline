nextflow.enable.dsl=2

include { seqSpecParser as seqSpecParser_rna}    from  './processes/seqSpecParser'
include { seqSpecParser as seqSpecParser_guide}    from  './processes/seqSpecParser'
include { seqSpecParser as seqSpecParser_multiseq}    from  './processes/seqSpecParser'

workflow {
    if (params.seqSpec_yaml_rna) {
        seqp_out_rna = seqSpecParser_rna(params.seqSpec_yaml_rna, 'rna')
    }
    
    if (params.seqSpec_yaml_guide) {
        seqp_out_guide = seqSpecParser_guide(params.seqSpec_yaml_guide, 'guide')
    }
    
    if (params.seqSpec_yaml_multiseq) {
        seqp_out_multiseq = seqSpecParser_multiseq(params.seqSpec_yaml_multiseq, 'multiseq')
    }
}
