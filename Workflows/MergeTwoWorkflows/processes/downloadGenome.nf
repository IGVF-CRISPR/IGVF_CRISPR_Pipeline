
process downloadGenome {
    input:
    val genome_path

    output:
    path "genome.fa.gz" , emit: genome

    script:
    """
        wget $genome_path -O genome.fa.gz
    """
}
