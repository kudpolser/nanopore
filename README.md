# nanopore
### G2 (SRR5665597, ERR1023775):
- Дейниченко Ксения Александровна
- Иванов Алексей Анатольевич
- Кудрявцева Полина Сергеевна
- Латышев Павел Васильевич

#### Скачайте прочтения
```
$ fastq-dump  --split-files ERR1023775 
$ fastq-dump  --split-files SRR5665597
```
#### Выберите из длинных прочтений самые длинные, суммарной длиной не более 400 миллионов п.н. 
```
$ conda install -c bioconda filtlong 
$ gzip SRR5665597.fastq
$ filtlong --target_bases 400000000 SRR5665597.fastq.gz | gzip > SRR5665597_f.fastq.gz
```
#### Cоберите геном бактерии из выбранных длинных и всех коротких прочтений, в гибридном режиме. 
```
$ conda install -c bioconda unicycler
$ gzip ERR1023775_1.fastq
$ gzip ERR1023775_2.fastq
$ unicycler -1 ERR1023775_1.fastq.gz -2 ERR1023775_2.fastq.gz -l SRR5665597_f.fastq.gz -o genome
```
#### Используя NCBI Blast, определите, к какому виду принадлежит собранная бактерия. 
Для того, чтобы определить вид собранной бактерии, последовательность, полученная в результате сборки генома была разделён на фрагменты, так как целый геном слишком большой для BLAST. BLAST запускался на нескольких фрагментах, по результатам был сделан вывод, что собранная бактерия принадлежит виду 
Klebsiella pneumoniae.

![GitHub Logo](/images/blast_1.png)

![GitHub Logo](/images/blast_2.png)

![GitHub Logo](/images/blast_3.png)
#### Визуализируйте сборку при помощи программы Bandage.
```
#download file to local computer
$ scp -P 9022 user_name@mg.uncb.iitp.ru:/mnt/local/vse2020/home/user_name/nanopore/genome/assembly.gfa .
```
File > Load graph > assembly.gfa

Graph drawing > Double

![GitHub Logo](/images/graph.png)

В итоге в сборке есть кольцевая молекула ДНК и две плазмиды.

#### Найдите в вашей сборке гены антибиотикорезистентности и вирулентности.
##### install abricate
```

$ mkdir utils
$ cd utils

### clone abricate
$ git clone https://github.com/tseemann/abricate.git
$ export PATH="/mnt/local/vse2020/home/<THERE WAS A USERNAME>/utils/abricate/bin:$PATH"

### install any2fasta (with abricate)
$ cd abricate/bin
$ wget https://raw.githubusercontent.com/tseemann/any2fasta/master/any2fasta
$ chmod +x any2fasta

### install Path::Tiny (with abricate) {install Perl5 locally [local::bin]}
$ perl -MCPAN -e shell
$ install Path::Tiny
$ cd ../..

$ cd ..
```

##### setup abricate
```
### check install
$ abricate --check

### download databases
$ abricate --setupdb

### check databases
$ abricate --list
```

##### run abricate for every databese
```
### save database names to file
$ abricate --list | cut -d'<THERE WAS \t>' -f1 | tail -n+2 > abricate_db_list.txt

### read file and run abricate with different database
$ cat abricate_db_list.txt | while read db
$ do
$   abricate --db $db --quiet assembly.fasta > "abr_result_$db.txt"
$ done
```

##### оставим только результаты с identity >95%
```
$ mkdir abricate_results_filt
$ cat abricate_db_list.txt | while read db
$ do
$   awk '$11>95' abr_result_$db.txt > abricate_results_filt/abr_result_filt_$db.txt
$ done
```

##### results
###### argannot
![GitHub Logo](/images/argannot.png)
###### card
![GitHub Logo](/images/card_1.png)
![GitHub Logo](/images/card_2.png)
###### ecoh
![GitHub Logo](/images/ecoh.png)
###### ecoli_vf
![GitHub Logo](/images/ecoli_vf.png)
###### megares
![GitHub Logo](/images/megares_1.png)
![GitHub Logo](/images/megares_2.png)
###### plasmid_finder
![GitHub Logo](/images/plasmid_finder.png)
###### resfinder
![GitHub Logo](/images/resfinder.png)
###### vfdb
![GitHub Logo](/images/vfdb.png)
