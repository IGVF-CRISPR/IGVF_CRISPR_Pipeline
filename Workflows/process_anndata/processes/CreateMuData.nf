
process CreateMuData {
  conda "./conda_envs/CreateMuData.yaml"

  input:

  path adata_rna
  path adata_guide
  path guide_metadata

  output:
  path "mudata.h5mu" , emit: mudata

  script:
        """
        create_mdata.py ${adata_rna} ${adata_guide} ${guide_metadata}
        """

}
