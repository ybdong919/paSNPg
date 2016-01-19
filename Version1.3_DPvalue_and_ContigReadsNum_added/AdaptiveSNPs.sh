#!/bin/bash
#$ -S /bin/bash
#$ -N getting_genotype
#$ -j y
#$ -cwd
#$ -R y
#export PATH=$PATH:/home/AAFC-AAC/dongy/mpp/bowtie2-2.2.3/:/home/AAFC-AAC/dongy/mpp/samtools:/home/AAFC-AAC/dongy/mpp/samtools/bcftools

sta=$(date)
tar -jxv -f ./Input_data/Pep_database.tar.bz2 -C ./
mv ./Input_data/*.fastq ./
./Scripts/generate_nuclear_contigs.sh
./Scripts/generate_exon_contigs.sh
./Scripts/call_exon_SNP.sh
./Scripts/call_nuclear_SNP_DP_ReadsNum.sh

perl ./Scripts/fasta_format.pl
rm allcontigs.fa exoncontigs.fa
echo "Calling SNPs is finished"

mv ./*.fastq ./Input_data/
rm -r Pep_database
fin=$(date)
echo -e "Adaptive running is over.\nStart time is $sta.\nFinish time is $fin."
