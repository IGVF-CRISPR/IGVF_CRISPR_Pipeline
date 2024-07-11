nextflow.enable.dsl=2

include { seqSpecParser as seqSpecParser_rna } from './processes/seqSpecParser1'
include { seqSpecParser as seqSpecParser_guide } from './processes/seqSpecParser1'
include { seqSpecParser as seqSpecParser_multiseq } from './processes/seqSpecParser1'

workflow {
    if (params.seqSpec_yaml_rna) {
        seqp_out_rna = seqSpecParser_rna(file("${params.seqSpecDirectory}/${params.seqSpec_yaml_rna}"), file(params.seqSpecDirectory), 'rna')
    }

    if (params.seqSpec_yaml_guide) {
        seqp_out_guide = seqSpecParser_guide(file("${params.seqSpecDirectory}/${params.seqSpec_yaml_guide}"), file(params.seqSpecDirectory), 'guide')
    }

    if (params.seqSpec_yaml_multiseq) {
        seqp_out_multiseq = seqSpecParser_multiseq(file("${params.seqSpecDirectory}/${params.seqSpec_yaml_multiseq}"), file(params.seqSpecDirectory), 'multiseq')
    }
}
