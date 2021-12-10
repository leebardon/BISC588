
#-------------------------------
#           GLOBALS 
#-------------------------------
BASE="/scratch/lbardon/data/tara_data"
ST="$BASE/samtools"
BT="$BASE/bowtie"


#-------------------------------
#           FUNCTIONS
#-------------------------------
clean_file () {

	sed -i 's/.sam-RAW/-RAW/g' $BASE/$1
	sed -i 's/.sam.DUMMY.bam/.bam/g' $BASE/$1
        sed -i '/ref_database/d' $BASE/$1
}

check_launcher_file_exists () {

    if test -f "$BASE/launcher_samtools.txt"; then
	    rm "$BASE/launcher_samtools.txt"
    fi

}

create_sam1_txt () {
    # bam to sam commands fo launcher 
    for file in *; do
        echo samtools view -F 4 -bS "$BT/$file" -o "$ST/$file"-RAW.bam >> $BASE/launcher_sam1.txt 
    done
}

create_sam2_txt () {
    # sort .bam
    for file in *; do
        echo samtools sort "$ST/$file"-RAW.bam -o "$ST/$file".DUMMY.bam >> $BASE/launcher_sam2.txt
    done
}

create_sam3_txt () {
    # index .bam
    for file in *; do
        echo samtools index -b "$ST/$file".DUMMY.bam >> $BASE/launcher_sam3.txt
    done
}


#-------------------------------
#           PROCEDURE
#-------------------------------

cd $BASE/bowtie

check_launcher_file_exists
create_sam1_txt && clean_file launcher_sam1.txt
create_sam2_txt && clean_file launcher_sam2.txt
create_sam3_txt && clean_file launcher_sam3.txt



# for set in *; do 
#     for file in `cat $set/r1.txt`; do 
#         mv /scratch/lbardon/data/tara_data/raw_reads/$file  /scratch/lbardon/data/tara_data/metagenomic_sets/$set/r1/
#     done
# done

#for file in *; do
    #echo samtools view -F 4 -bS "$BT/$file" -o "$ST/$file"-RAW.bam samtools sort "$ST/$file"-RAW.bam -o "$ST/$file".DUMMY samtools index "$ST/$file".DUMMY >> $BASE/launcher_samtools.txt
#done


#sed -i 's/.sam-RAW/-RAW/g' $BASE/launcher_samtools.txt
#sed -i 's/.sam.DUMMY/.bam/g' $BASE/launcher_samtools.txt
#sed -i 's/.sam-RAW/-RAW/g' $BASE/launcher_sam_step1.txt
#sed -i 's/.sam.DUMMY.bam/.bam/g' $BASE/launcher_sam_step2.txt
#sed -i 's/.sam.DUMMY.bam/.bam/g' $BASE/launcher_sam_step3.txt
