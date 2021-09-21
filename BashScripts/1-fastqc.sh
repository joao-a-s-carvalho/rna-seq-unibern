#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=3000M
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqcJoao
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%A_%a_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%A_%a_%j.txt
#SBATCH --array=0-11

# --array the number of paralel computers assigend with required cpus and memory, here 6 because there are 6 files
# --nodes number of machines where my cpus are coming from 

filesDir=/data/courses/rnaseq/summer_practical/reads
outputDir=/data/courses/rnaseq/summer_practical/joao_rnaseq/quality_checks

#Selecting samples HER2+ and TNB+ (in brackets creates an array automatically)
sampleFiles=($(ls -d $filesDir/* | grep 'HER.*\|\WTNB.*'))

#Loading fastqc before running it (see https://www.vital-it.ch/services?type=tool&term=fastqc-0.11.9)
echo -e "Loading fastqc.\n"
module add UHTS/Quality_control/fastqc/0.11.9
echo -e "Modules loaded"


echo -e ${sampleFiles[$SLURM_ARRAY_TASK_ID]}


fastqc ${sampleFiles[$SLURM_ARRAY_TASK_ID]} --outdir $outputDir --threads 8
