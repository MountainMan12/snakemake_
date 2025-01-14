# Course: Snakemake tutorial for life sciences

## Source: Udemy

### Course Content

#### 1. Setting up the environment

1.1 Download Data 

`curl -L `

1.2 Setting up conda environment

`conda create --name snakemake-tutorial --channel bioconda --channel conda-forge --yes snakemake`

1.3 Install required packages

`conda install jinja2`  
`conda install networkx`  
`conda install matplotlib`  
`conda install graphviz`  

If operating system is macOS, you can install NGS packages using the homebrew formulae

`brew install samtools`  
`brew install bcftools`  

#### 2. Useful commands

2.1 Running a snakemake workflow

`snakemake --cores 6 sorted_reads/{sample}.bam.bai -p`

The `-n` flag can be used to perform a dry-run of the pipeline. 

2.2 Visualising DAG of snakemake workflow

`snakemake --dag sorted_reads/{sample}.bam.bai | dot -Tsvg > dag.svg`

*NOTE: The dot library is installed alongside the snakemake package installation from conda*

2.3 Specifying a target file

In the Snakemake file, the first rule is a special rule that is called `rule all`.  
This rule contains an input that is the target file, e.g. `calls/all.vcf`  

After specifying the target file, the snakemake command becomes, 

`snakemake --cores 1 -p`

