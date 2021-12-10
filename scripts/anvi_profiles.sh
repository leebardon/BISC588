BASE="/scratch/lbardon/data/tara_data"
ST="$BASE/samtools"
BT="$BASE/bowtie"

if test -f "$BASE/launcher_anvi_profs.txt"; then
	rm "$BASE/launcher_anvi_profs.txt"
fi

cd $BASE/bowtie
for file in *; do
    echo samtools view -F 4 -bS "$BT/$file" -o "$ST/$file"-RAW.bam samtools sort "$ST/$file"-RAW.bam -o "$ST/$file".DUMMY samtools index "$ST/$file".DUMMY >> $BASE/launcher_samtools.txt
done


sed -i 's/.sam-RAW/-RAW/g' $BASE/launcher_samtools.txt
sed -i 's/.sam.DUMMY/.bam/g' $BASE/launcher_samtools.txt
