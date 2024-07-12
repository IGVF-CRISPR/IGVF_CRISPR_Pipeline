nextflow.enable.dsl=2

include { downloadReference } from './processes/ref_download.nf'

workflow{
    index = downloadReference(params.TRANSCRIPTOME_REFERENCE)
}
