#!/bin/bash

echo "Calling nuclear SNPs is beginning"
bowtie2-build allcontigs.fa bt2ref
ref=allcontigs.fa
samtools faidx $ref

for file1 in *R1_001.fastq
do
   file2=$(echo ${file1} | sed 's/R1_001/R2_001/') 
   bowtie2 -x bt2ref -1 $file1 -2 $file2 -S $file1.sam --no-unal
   samtools view -Sbt ${ref}.fai ${file1}.sam > ${file1}.bam
   samtools sort ${file1}.bam ${file1}.sorted
   
   samtools view -F 4 ${file1}.sorted.bam | cut -f3 | uniq -c > ${file1}.readsnum   ## get reads count of every samples matching each contig
   echo -e "${file1}.readsnum" >> readsnum_namefiles                                ## get reads count of every samples matching each contig
   
   samtools index ${file1}.sorted.bam
   samtools mpileup -uf $ref ${file1}.sorted.bam | bcftools view -cg -> ${file1}.vcf
   rm *.bai *.bam *.sam

   echo -e "${file1}.vcf" > dirfile
   perl ./Scripts/screen_sampleSNP_DP.pl
   rm *step1*.vcf *step2*.vcf   
done
perl ./Scripts/contig_reads_num.pl                   ## get reads count of every samples matching each contig
perl ./Scripts/identify_SNP_DP.pl
perl ./Scripts/dpvalues_output.pl                  ## get DP value of each SNP, each sample
mv part_Clean_SNP_Genotypes.txt ./Output_results/Nu_SNP_genotypes.txt
mv part_Clean_SNP_hap.txt ./Output_results/Nu_SNP_hap.txt
rm All_SNP_Genotypes.txt All_SNP_hap.txt All_SNP_Genotypes_DP.txt 
rm GT_data_without_duplication.txt
rm *.vcf *.bt2 *.fai *name* dirfile *align_contigs All_GTs.txt
rm pre_Clean_SNP_hap.txt
rm *.readsnum readsnum_namefiles

