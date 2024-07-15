
include {seqSpecParser} from './processes/seqSpecParser.nf'
include {downloadGenome} from './processes/downloadGenome.nf'
include {creatingGuideRef} from './processes/createGuideIndex.nf'
include {mappingGuide} from './processes/mappingGuide.nf'

workflow {
    seqSpecResult = seqSpecParser(
        file("${params.seqSpecDirectory}/${params.seqSpec_yaml_guide}"),
        file(params.seqSpecDirectory),
        'guide')
        
    genome = downloadGenome(params.genome_path)
    GuideRef = creatingGuideRef(genome.genome, file(params.guide_features))

    MappingOut = mappingGuide(
        tuple(file(params.fastq_file1), file(params.fastq_file2)),
        GuideRef.guide_index,
        GuideRef.t2tguide_index,
        seqSpecResult.parsed_seqspec,
        seqSpecResult.whitelist)
}
