
process seqSpecParser {
  conda "./conda_envs/seqSpecParser.yaml"

  input:
    path seqSpec_yaml
    path directory
    val modalities

  output:
    path "${modalities}_parsed_seqSpec.txt", emit: parsed_seqspec

  script:
    """
    parsing_guide_metadata.py --modalities ${modalities} --yaml_file ${seqSpec_yaml} --directory ${directory} --output_file ${modalities}_parsed_seqSpec.txt
    """
}