#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=00:55:00
#SBATCH --mem=64GB

module purge
module load gcc/9.2.0 
module load blast-plus/2.11.0

$BLAST_TYPE -query $SEQUENCE -db $DB -out $BASE/$OUTFILE