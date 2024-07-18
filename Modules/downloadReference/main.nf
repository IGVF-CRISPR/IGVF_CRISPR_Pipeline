nextflow.enable.dsl=2

include { downloadReference } from './processes/downloadReference.nf'

workflow{
    index = downloadReference(params.TRANSCRIPTOME_REFERENCE)
}
