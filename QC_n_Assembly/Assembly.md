#concantenate data

cat *.fastq.gz > hp_trial.fastq.gz

porechop -i hp_trial.fastq.gz -o hp_trial_trimmed.fastq.gz

Long read assembly:

unicycler -l hp_trial_trimmed.fastq.gz --min_fasta_length 200  -o unicycler_assembled


hybrid assembly:

unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -l long_reads.fastq.gz -o output_dir


Short reads

unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -o output_dir


canu 

canu -p try_1 -d canu_assembled genomeSize=1.6m -nanopore hp_trial_trimmed.fastq.gz 


Flye


flye --nano-raw hp_trial.fastq.gz --out-dir hp_trial_flye --genome-size 1.6m