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
$ gzip SRR5665597.fastq
$ filtlong --target_bases 400000000 SRR5665597.fastq.gz | gzip > SRR5665597_f.fastq.gz
```
#### Cоберите геном бактерии из выбранных длинных и всех коротких прочтений, в гибридном режиме. 
```
gzip ERR1023775_1.fastq
gzip ERR1023775_2.fastq
unicycler -1 ERR1023775_1.fastq.gz -2 ERR1023775_2.fastq.gz -l SRR5665597_f.fastq.gz -o genome
```
#### Используя NCBI Blast, определите, к какому виду принадлежит собранная бактерия. 
Klebsiella pneumoniae strain INF059
#### Визуализируйте сборку при помощи программы Bandage.

#### Найдите в вашей сборке гены антибиотикорезистентности и вирулентности. 