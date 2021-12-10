BASE="/scratch/lbardon/data/tara_data"
DB="/scratch/lbardon/data/tara_data/ref_genome/LSUCC0859_db"
BT="$BASE/bowtie"

if test -f "$BASE/launcher_bowtie.txt"; then
	rm "$BASE/launcher_bowtie.txt"
fi

cd $BASE/metagenomic_sets

for set in *; do 
    paste -d "," $set/r1.txt $set/r2.txt > $set/r1r2.txt
    sed -i "s/,/dummy\/scratch\/lbardon\/data\/tara_data\/metagenomic_sets\/$set\/r2\//g" $set/r1r2.txt
    sed -i -e "s/^/\/scratch\/lbardon\/data\/tara_data\/metagenomic_sets\/$set\/r1\//" $set/r1r2.txt
    sed -i 's/.gz//g' $set/r1r2.txt
done


for set in *; do
    i=1
    for line in `cat $set/r1r2.txt`; do 
        echo bowtie2 -x $DB -1 $line -S $BT/$set"_"$i"_R1R2.sam" >> $BASE/launcher_bowtie.txt	
	((i=i+1))
    done
done

sed -i 's/dummy/ -2 /g' $BASE/launcher_bowtie.txt

# for set in *; do 
#     for file in `cat $set/r1.txt`; do 
#         mv /scratch/lbardon/data/tara_data/raw_reads/$file  /scratch/lbardon/data/tara_data/metagenomic_sets/$set/r1/
#     done
# done