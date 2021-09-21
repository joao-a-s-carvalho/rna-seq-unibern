#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=2000M
#SBATCH --nodes=1
#SBATCH --time=01:00:00
#SBATCH --job-name=fastpJoao
#SBATCH --mail-user=joao.carvalho@ana.unibe.ch
#SBATCH --mail-type=begin,end
#SBATCH --output=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/outfile_generated_%A_%a_%j.txt
#SBATCH --error=/data/courses/rnaseq/summer_practical/joao_rnaseq/outputs/errfile_generated_%A_%a_%j.txt
#SBATCH --array=0-5

# --array the number of paralel computers assigend with required cpus and memory, here 6 because there are 6 files
# --nodes number of machines where my cpus are coming from 

filesDir=/data/courses/rnaseq/summer_practical/reads
outputDir=/data/courses/rnaseq/summer_practical/joao_rnaseq/trimmed

#Selecting samples HER2+ and TNB+ (in brackets creates an array automatically)
sampleFiles=($(ls -d $filesDir/* | grep 'HER.*_R1.*\|\WTNB.*R1.*'))

#Loading programm before running it (see https://www.vital-it.ch/services?type=tool&term=fastqc-0.11.9)
echo -e "Loading modules.\n"
module add UHTS/Quality_control/fastp/0.19.5
echo -e "Modules loaded"

echo -e ${sampleFiles[$SLURM_ARRAY_TASK_ID]}

fq1=${sampleFiles[$SLURM_ARRAY_TASK_ID]}
fq2=$(echo $fq1 | sed 's/_R1/_R2/g')

fqtrim1=$(echo $fq1 | sed "s|_R1|_R1_trimmed|g" | sed "s|$filesDir|$outputDir|g")
fqtrim2=$(echo $fq1 | sed 's|_R1|_R2_trimmed|g' | sed "s|$filesDir|$outputDir|g")

fastp -i $fq1 -I $fq2 -o $fqtrim1 -O $fqtrim2 --thread 4

