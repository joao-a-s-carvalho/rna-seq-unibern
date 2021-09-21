#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --nodes=1
#SBATCH --time=04:00:00
#SBATCH --job-name=StarIndexJoao
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%j.txt

#Loading program before running it (see https://www.vital-it.ch/services?type=tool&term=fastqc-0.11.9)
echo -e "Loading fastqc.\n"
module add UHTS/Aligner/STAR/2.7.9a
echo -e "Modules loaded"

#I had to uncompress the files separately as the option --readFilesCommand zcat \ is not working


STAR --runThreadN 16 \
--runMode genomeGenerate \
--genomeDir /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/index \
--genomeFastaFiles /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--sjdbGTFfile /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/Homo_sapiens.GRCh38.104.gtf \
--sjdbOverhang 59

# --sjdbOverhang Max read size, can be checked in the fastqc file in the general settings, in the option that number minus 1
# --readFilesCommand zcat option needed because the files are compressed
