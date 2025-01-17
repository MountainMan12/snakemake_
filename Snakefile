SAMPLES = ['A', 'B', 'C']

rule all:
    input:
        'calls/all.vcf'

rule bwa_map:
    input:
        'data/genome.fa',
        'data/samples/{sample}.fastq',
    output:
        'mapped_reads/{sample}.bam'
    shell:
        'bwa mem {input} | samtools view -Sb - > {output}'

rule samtools_sort:
    input:
        'mapped_reads/{sample}.bam'
    output:
        'sorted_reads/{sample}.bam'
    shell:
        'samtools sort -T sorted_reads/{wildcards.sample} '
        '-O bam {input} > {output}'

rule samtools_index:
    input:
        bam = 'sorted_reads/{sample}.bam'
    output:
        'sorted_reads/{sample}.bam.bai'
    shell:
        'samtools index {input.bam}'

rule bcftools_call:
    input:
        fa = 'data/genome.fa',
        bam = expand('sorted_reads/{sample}.bam', sample = SAMPLES),
        bai = expand('sorted_reads/{sample}.bam.bai', sample = SAMPLES),
    output:
        'calls/all.vcf'
    shell:
        'bcftools mpileup -f {input.fa} {input.bam} | '
        'bcftools call -mv - > {output}'
