#!/bin/bash
#$ -S /bin/bash
#$ -N getting_genotype
#$ -j y
#$ -cwd
#$ -R y
#export PATH=$PATH:/home/AAFC-AAC/dongy/mpp/bowtie2-2.2.3/:/home/AAFC-AAC/dongy/mpp/samtools:/home/AAFC-AAC/dongy/mpp/samtools/bcftools

echo "Calling exon SNPs is beginning"
bowtie2-build exoncontigs.fa bt2ref
ref=exoncontigs.fa
samtools faidx $ref

for file1 in *R1_001.fastq
do

   #echo $file1 
   file2=$(echo ${file1} | sed 's/R1_001/R2_001/') 
   #echo $file2 
 
   bowtie2 -x bt2ref -1 $file1 -2 $file2 -S $file1.sam --no-unal 
   samtools view -Sbt ${ref}.fai ${file1}.sam > ${file1}.bam
   samtools sort ${file1}.bam ${file1}.sorted
   samtools index ${file1}.sorted.bam
   samtools mpileup -uf $ref ${file1}.sorted.bam | bcftools view -cg -> ${file1}.vcf
   rm *.bai *.bam *.sam

   echo -e "${file1}.vcf" > dirfile
   perl ./Scripts/screen_sampleSNP.pl
   rm *step1*.vcf *step2*.vcf
    
done
perl ./Scripts/identify_SNP.pl
mv part_Clean_SNP_Genotypes.txt ./Output_results/NE_SNP_genotypes.txt
mv part_Clean_SNP_hap.txt ./Output_results/NE_SNP_hap.txt
rm All_SNP_Genotypes.txt All_SNP_hap.txt
rm GT_data_without_duplication.txt 
rm *.vcf *.bt2 *.fai *name* dirfile *align_contigs All_GTs.txt
rm pre_Clean_SNP_hap.txt


