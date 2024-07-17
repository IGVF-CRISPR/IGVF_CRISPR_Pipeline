
nextflow.enable.dsl=2

include { mapping_rna_pipeline } from './mapping_rna_pipeline.nf'
include { mapping_guide_pipeline } from './mapping_guide_pipeline.nf'

workflow {
  mapping_rna_pipeline()
  mapping_guide_pipeline()
}
