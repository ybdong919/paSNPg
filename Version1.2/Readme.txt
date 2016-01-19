Getting Started with AdaptiveSNPsv1.2

Steps to Use AdaptiveSNPsv1.2:
1. Familiarize yourself with AdaptiveSNPsv1.2 by reading Getting Started with AdaptiveSNPsv1.2_pipeline.txt (this file) attached in the pipeline folder.
2. Install all required free software, set up paths to access those computer programs, and test if installed software is working by typing: minia, bowtie2, SAMtools, blast or perl separately.
3. Create a directory for the AdaptiveSNPsv1.2 pipeline and copy the whole pipeline to this directory.
4. Upload all FASTQ data into the subfolder “Input_data”.
5. If needed, adjust the related parameters for the output files NE_contigs.fasta by editing Pident_Plength.txt in the subfolder “Threshold_set”. 
6. Start the pipeline by running the shell file AdaptiveSNPs.sh by typing: ./AdaptiveSNPs.sh at the command prompt.
7. Nine output files are generated in the subfolder “Output_results” in the same directory of AdaptiveSNPs. 
8. Optionally, adjust the related parameters for removing SNP sites with missing by editing Missing_threshold.txt in the subfolder “Threshold_set”. Then run the shell script remove_missingSNPs.sh by typing: ./remove_missingSNPs.sh at the command prompt. Another six output files (Clean_*.*) are generated in the subfolder “Output_results” in the same directory of AdaptiveSNPs.
9. If only nuclear SNPs are wanted while exon regions do not need to be analyzed, please run the shell file miniAdaptiveSNPs.sh instead of AdaptiveSNPs.sh.  

Prerequisite:
1) Minia (http://minia.genouest.org/). Extend k-mer length to 100 by typing: make clean && make k=100
2) Bowtie2 (http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
3) SAMtools (http://samtools.sourceforge.net/) 
4) Perl in Linux (http://www.perl.org/get.html)
5) Fastx_collapser (http://hannonlab.cshl.edu/fastx_toolkit/). Download it to the same directory of Minia.
6) Blast+( http://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download).
                
Input files:
1) Paired-end Illumina sequencing data files with FASTQ format are used.
2) Two input files in the "Threshold_set" subfolder with adjustable parameters for the output file:
i) Pident_Plength.txt is used to identify the contigs located in nuclear exon regions. The parameters of “Pident” and “Plength” are percentage of identical matches and alignment length, respectively. The default settings are 75% and 99%.   
     ii) Missing_threshold.txt is used to remove the loci having a level of missing observations or higher; normally 10-20%. The default setting is 0%. (Optional)
3) Protein database of 38 plant species compressed by tarball in the folder “Input_data” are used. 
 
Output files:
Nu_contigs.fasta consists of de novo assembly contigs from all samples as a reference for nuclear SNP genotyping.
Nu_SNP_genotypes.txt includes nuclear SNP genotype data after removing SNPs showing the same genotypes for all samples and residing within 20 bases from both ends of each contig.
Nu_SNP_hap.txt is unphased haplotype data corresponding to Nu_SNP_Genotypes.txt. 
Nu_SNP_hap.fasta is a data file with a FASTA format corresponding to Nu_SNP_hap.txt.

NE_contigs.fasta consists of de novo assembly contigs in nuclear exon regions from all samples as a reference for SNP genotyping in exon regions.
NE_contigs_information.txt consists of proten information associated with the contigs in nuclear exon regions.
NE_SNP_genotypes.txt includes nuclear SNP genotype data after removing SNPs showing the same genotypes for all samples and residing within 20 bases from both ends of each contig.
NE_SNP_hap.txt is unphased haplotype data corresponding to NE_SNP_Genotypes.txt. 
NE_SNP_hap.fasta is a data file with a FASTA format corresponding to NE_SNP_hap.txt.

If  missing_lever.pl is selected to run, Clean_Nu_SNP_genotypes.txt, Clean_Nu_SNP_hap.txt, Clean_Nu_SNP_hap.fasta, Clean_NE_SNP_genotypes.txt, Clean_NE_SNP_hap.txt and Clean_ NE_SNP_hap.fasta also will be outputted. 

If miniAdaptiveSNPs.sh is runned instead of  AdaptiveSNPs.sh, only nuclear results will be outputted.  


