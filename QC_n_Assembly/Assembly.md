## Concantenate Data
cat *.fastq.gz > hp_trial.fastq.gz

## Trimming with porechop
porechop -i hp_trial.fastq.gz -o hp_trial_trimmed.fastq.gz

# Assemby of Nanopore/Pacbio reads
## 1. Unicycler *(Note: Best for hybrid assemby but can assemble long and short reads)*
### For long reads:
unicycler -l hp_trial_trimmed.fastq.gz --min_fasta_length 200  -o unicycler_assembled

### For hybrid assembly:
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -l long_reads.fastq.gz -o output_dir

### For short reads
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -o output_dir

## Canu 
canu -p prefix -d output_directory genomeSize=1.6m -nanopore sample_id_trimmed.fastq.gz 

## Flye
flye --nano-raw sample_id.fastq.gz --out-dir desired_folder_name --genome-size 1.6m
