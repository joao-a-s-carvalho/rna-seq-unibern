#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --nodes=1
#SBATCH --time=15:00:00
#SBATCH --job-name=StarAlignJoao
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%A_%a_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%A_%a_%j.txt
#SBATCH --array=0-5

#Loading program before running it (see https://www.vital-it.ch/services?type=tool&term=fastqc-0.11.9)
echo -e "Loading fastqc.\n"
module add UHTS/Aligner/STAR/2.7.9a
echo -e "Modules loaded"

filesDir=/data/courses/rnaseq/summer_practical/joao_rnaseq/trimmed
sampleFiles=($(ls -d $filesDir/* | grep '.*R1.*fastq.gz'))

fq1=${sampleFiles[$SLURM_ARRAY_TASK_ID]}
fq2=$(echo $fq1 | sed 's/_R1/_R2/g')
filename=$(echo $fq1 | sed 's/_R1_trimmed.fastq.gz//g')

echo $fq1 $fq2 $filename

STAR --runThreadN 16 \
--genomeDir /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/index \
--readFilesCommand zcat \
--readFilesIn $fq1 $fq2 \
--outFileNamePrefix /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/STAR/${filename}_star_align \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard 

# --readFilesIn for paired end format is list of reads 1 comma separated, then space, then list of comma separated reads 2
# --outFileNamePrefix the name need to change otherwise the files will overwrite one another! because of the 
# array slurm config STAR can't separate it's own
