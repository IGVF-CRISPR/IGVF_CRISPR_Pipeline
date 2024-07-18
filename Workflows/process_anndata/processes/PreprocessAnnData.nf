
process PreprocessAnnData {
  conda "./conda_envs/PreprocessAnnData.yaml"

  input:
  path adata_rna
  path gname_rna
  val min_genes
  val min_cells
  val reference

  output:
  path "filtered_anndata.h5ad" , emit: filtered_anndata_rna

  script:
        """
        preprocess_adata.py ${adata_rna} ${gname_rna} --min_genes ${min_genes} --min_cells ${min_cells} --reference ${reference}
        """

}
