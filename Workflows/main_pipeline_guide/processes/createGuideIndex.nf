
process creatingGuideRef {
    cache 'lenient'
    conda "./conda_envs/createGuideIndex.yaml"

    input:
    path genome
    path guide_features

    output:
    path "guide_index.idx" ,  emit: guide_index
    path "t2guide.txt" , emit: t2guide

    script:

    """
        k_bin=\$(which kallisto)
        guide_features_table=\$(guide_features.py --guide_table ${guide_features})
        kb ref -i guide_index.idx -f1 $genome -g t2guide.txt --kallisto \$k_bin  --workflow kite guide_features.txt
    """

}
