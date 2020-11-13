#!/bin/bash
abricate --check
abricate --setupdb
abricate --list

abricate --list | cut -d'       ' -f1 | tail -n+2 > abricate_db_list.txt
cat abricate_db_list.txt | while read db
do
    abricate --db $db --quiet assembly.fasta > "abr_result_$db.txt"
done