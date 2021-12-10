BASE=/scratch/lbardon/data/tara_data

check_for_argument () {

    # If argument is given at launch (a directory from $BASE/), searches that dir
    # elses searches default dir

    if [ $# -eq 0 ]
    then
        DIR=$BASE/bowtie
    else 
        DIR=$BASE/$1
    fi
}

check_for_argument $1

cd $DIR

for file in *; do
       [ -s $file ] && echo "Ok" || echo "$file - empty"
done
