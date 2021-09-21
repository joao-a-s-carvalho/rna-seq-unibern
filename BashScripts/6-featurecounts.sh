#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=4G
#SBATCH --nodes=1
#SBATCH --time=15:00:00
#SBATCH --job-name=featurecountsJoao
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%j.txt

module add UHTS/Analysis/subread/2.0.1;

sampleFiles=( $(ls -d /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/STAR/*.bam) )

featureCounts -T 16 -s 0 -p \
-a /data/courses/rnaseq/summer_practical/joao_rnaseq/mapping/Homo_sapiens.GRCh38.104.gtf \
-o /data/courses/rnaseq/summer_practical/joao_rnaseq/breast_cancer2_featurecounts.txt \
${sampleFiles[*]}

