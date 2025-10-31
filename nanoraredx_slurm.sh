#!/bin/bash
#SBATCH --job-name=nanoraredx_clinical
#SBATCH --cpus-per-task=32
#SBATCH --time=8-0:0:0
#SBATCH --account=beggsa-genomicsbirmingham
#SBATCH --qos=bbdefault

module purge
module load bluebear
module load bear-apps/2022b
module load Nextflow/25.04.6

nextflow run main.nf -profile test,singularity
