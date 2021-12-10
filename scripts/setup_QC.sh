#!/bin/bash

#--------------------------------------------------------------------------------------
# A script for generating QC commands for each .fastq file, to be used with launcher.
#--------------------------------------------------------------------------------------

generate_QC_commands () {

    # Function generates QC commands for each .fastq file, 
    # to be used with launcher
    
    for file in `cd $FASTQ_DIR && ls`; do
	if [[ $file == *.fastq ]]
        then
           echo fastqc -f fastq -t 16 $file ;
        fi
    done | cat > QC.txt && mv QC.txt $FASTQ_DIR

}

request_input () {
    
    # Function takes user input on command line to obtain dir containing .fastq files
    
    printf "\n\n-------------- GENERATING QC COMMANDS FOR EACH .fastq FILE --------------\n\n"
    printf "\n >>> Which week is this work for? E.g. '6' : \n"
    read WEEK
    FASTQ_DIR=/project/thrash_425/lbardon/week$WEEK/data/trimmed
    printf "\n >>> Are your TRIMMED files contained in:\n $FASTQ_DIR ? \n Enter (y/n) \n"
    read answer

    if [[ ! $answer = "y" ]]; then
        request_input
    fi
}


build_slurm_script () {

    # Function builds generic slurm script based on number of tasks,
    # calculated as num of .fastq files. Default 16 CPU's requested per task
    # Default memory requested=0, default time 0:59:00, all adjustable below. 

    NUM_TASKS=`wc -l < $FASTQ_DIR/QC.txt`
    CPUS=16
    MEM=0
    TIME=0:59:00
    
    printf "\n\n---------------------- BUILDING SLURM SCRIPT ----------------------\n\n"
    printf "\n >>> You have $NUM_TASKS .fastq files in the given directory. \n"
    printf "\n  >>> Suggested flag values: \n\n " 
    printf "          \n#SBATCH --nodes=$NUM_TASKS "
    printf "          \n#SBATCH --ntasks=$NUM_TASKS "
    printf "          \n#SBATCH --cpus-per-task=$CPUS "
    printf "          \n#SBATCH --mem=$MEM "
    printf "          \n#SBATCH --time=$TIME "
    printf "\n\n >>> To accept, enter 'y', or manually set up and run slurm script:\n"

    read answer
    
    if [[ $answer = "y" ]]; then
        printf "\n >>> Submitting job... \n\n"
        export WORKDIR=$FASTQ_DIR
        sbatch --nodes=$NUM_TASKS --ntasks=$NUM_TASKS qc_launcher.slurm -export=WORKDIR
    else 
        printf "\n ----- bye! ----- \n" 
    fi
    
}

#-------------------------------------------
#               PROCEDURE
#-------------------------------------------

request_input && generate_QC_commands
printf "\n >>> Created QC.txt in: \n $FASTQ_DIR \n\n "

printf "\n Would you like to evaluate cleaned reads now? (y/n) \n"
read answer

if [[ $answer = "y" ]]; then
    build_slurm_script
else
    echo "\n --- DONE ---\n "
fi


