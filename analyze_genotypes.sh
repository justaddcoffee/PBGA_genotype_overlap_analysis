#!/bin/bash
dataDir="./data"
outputFile="analyze_genotypes.tsv"
echo -e "0/0\t0/1\t1/1\t./.\ttotalVCFlines\toverlapping SVs" > $outputFile
for file in $(find $dataDir -name "*gz" | sort)
do
    echo -n -e $(basename "$file") "\t" >> $outputFile
    for thisgt in "0/0" "0/1" "1/1" "\./\."
    do
	    gzcat "$file" | grep -v "^#" | cut -f10 -d$'\t'  | cut -f1 -d':' | grep -c "$thisgt" | tr '\n' '\t' >> $outputFile
    done
	  gzcat "$file" | grep -v "^#" | cut -f10 -d$'\t'  | cut -f1 -d':' | grep -c "" | tr '\n' '\t' >> $outputFile

	  # get count of overlapping SVs from db
	  unpigz -p 8 -c annotated/$(basename "$file") | wc -l | awk '{printf "%11.9f\n",$1/100000}' >> $outputFile
done
