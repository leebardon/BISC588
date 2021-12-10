#!/bin/bash

BASE=/project/thrash_425/lbardon/final_project/data/ref_genome/blast_out
DEFAULT_DB=/project/thrash_425/db/NCBI/nt
SCRIPTS_DIR=/project/thrash_425/lbardon/final_project/scripts

#--------------------------------------------------------------------------------------
# A script for submitting blast queries via sbatch.
# Collects Blast type, query sequence file, database and output file from user 
# Assumes query sequence is in $BASE/blast_out dir defined above
# Assumes blast.slurm is in the scripts directory defned above
#--------------------------------------------------------------------------------------


set_variables () {

PS3=">>> Select type of blast query (choose number): "

select BLAST_TYPE in blastn blastx tblastn blastp
do 
    printf "\nYou selected $BLAST_TYPE - is that correct? (y/n) \n"
    read answer

        if [[ $answer = "y" ]]; then
            break
        else
            continue
        fi
done

printf "\n>>> Please enter filename of query sequence: \n"
printf "*** NOTE ***  assumes file is in $BASE \n"
read SEQ

SEQUENCE=$BASE/$SEQ


printf "\n>>> Would you like to BLAST against default database at $DEFAULT_DB ? (y/n) \n"
read answer

    if [[ $answer = "y" ]]; then
        DB=$DEFAULT_DB
    else
        printf ">>> Please enter path to database: \n"
        read SEQUENCE
    fi

printf "\n>>> Please enter output filename: \n"
read OUTFILE

# export BLAST_TYPE, SEQUENCE, DB, OUTFILE

}

check_variables () {

    printf "\nYou selected: \n"
    printf "   |     Blast type: $BLAST_TYPE \n"
    printf "   |     Query sequence: $SEQUENCE \n"
    printf "   |     Database: $DB \n" 
    printf "   |     Output filename: $OUTFILE \n" 

}


printf "\n --------------------------------------------------------------------------------------\n"
printf "                                SBATCH YOUR BLAST                                       \n"
printf " --------------------------------------------------------------------------------------\n"

set_variables && check_variables

printf "\n\n > Does this look right to you? (y/n) \n"
read answer

    if [[ $answer = "y" ]]; then
        cd $SCRIPTS_DIR
        printf "\n >>>>>>>> Submitting job <<<<<<<<< \n\n"
        sbatch --export=ALL,BASE=$BASE,BLAST_TYPE=$BLAST_TYPE,SEQUENCE=$SEQUENCE,DB=$DB,OUTFILE=$OUTFILE blast.slurm 
    else
        set_variables && check_variables
    fi
