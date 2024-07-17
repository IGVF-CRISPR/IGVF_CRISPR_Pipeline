
nextflow.enable.dsl=2

include { seqSpecParser } from './processes/seqSpecParser.nf'
include { downloadGenome } from './processes/downloadGenome.nf'
include { creatingGuideRef } from './processes/createGuideIndex.nf'
include { mappingGuide } from './processes/mappingGuide.nf'

workflow mapping_guide_pipeline {

    seqSpecResult = seqSpecParser(
        file("${params.seqSpecDirectory}/${params.seqSpec_yaml_guide}"),
        file(params.seqSpecDirectory),
        'guide')

    genome = downloadGenome(params.genome_path)
    GuideRef = creatingGuideRef(genome.genome, file(params.guide_features))

    MappingOut = mappingGuide(
        file(params.fastq_files_guide),
        tuple(params.fastq_file1_guide, params.fastq_file2_guide),
        GuideRef.guide_index,
        GuideRef.t2guide,
        seqSpecResult.parsed_seqspec,
        seqSpecResult.whitelist)
}
