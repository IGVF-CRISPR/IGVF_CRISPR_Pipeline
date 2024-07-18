
nextflow.enable.dsl=2

include { PreprocessAnnData } from './processes/PreprocessAnnData.nf'
include { CreateMuData } from './processes/CreateMuData.nf'

workflow {

    Preprocessed_AnnData = PreprocessAnnData(
        file(params.adata_rna),
        file(params.gname_rna),
        params.min_genes,
        params.min_cells,
        params.TRANSCRIPTOME_REFERENCE)

    MuData = CreateMuData(
        Preprocessed_AnnData.filtered_anndata_rna,
        file(params.adata_guide),
        file(params.guide_features))
}
