# for set in *; do 
#     for file in `cat $set/r1.txt`; do 
#         mv /scratch/lbardon/data/tara_data/raw_reads/$file  /scratch/lbardon/data/tara_data/metagenomic_sets/$set/r1/
#     done
# done

BASE="/scratch/lbardon/data/tara_data"

cd $BASE

for set in metagenomic_sets/*; do 
    for file in `cat $set/r1.txt`; do 
        echo gunzip $BASE/$set/r1/$file >> launcher_unzip.txt
    done
        for file in `cat $set/r2.txt`; do 
        echo gunzip $BASE/$set/r2/$file >> launcher_unzip.txt
    done
done
