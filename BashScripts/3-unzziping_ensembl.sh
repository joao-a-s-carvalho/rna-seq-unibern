#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8G
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --job-name=unzziping
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%j.txt

gunzip -d Homo_sapiens.GRCh38.104.gtf.gz Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz


