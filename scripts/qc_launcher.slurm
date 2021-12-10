#!/bin/bash

#------------------------------------------------------------------------------------
# NOTE: To manually set up, uncomment ##SBATCH --nodes=$(1) and ##SBATCH --ntasks=$(1)
# and set to desired values   
#-------------------------------------------------------------------------------------

##SBATCH --nodes=2
##SBATCH --ntasks=2
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --time=0:59:00

module purge
module load launcher
module load usc hwloc
module load gcc/8.3.0
module load intel/19.0.4
module load fastqc

export LAUNCHER_DIR=$LAUNCHER_ROOT
export LAUNCHER_RMI=SLURM
export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_SCHED=interleaved
export LAUNCHER_WORKDIR=$WORKDIR
export LAUNCHER_BIND=1
export LAUNCHER_JOB_FILE=$WORKDIR/QC.txt
$LAUNCHER_DIR/paramrun
