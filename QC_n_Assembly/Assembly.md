### Scripts for trimming and Assembly 
#### Concantenate Data
```{shell}
cat *.fastq.gz > hp_trial.fastq.gz
```

#### Trimming with porechop
```{shell}
porechop -i hp_trial.fastq.gz -o hp_trial_trimmed.fastq.gz
```

#### Assemby of Nanopore/Pacbio reads
#### 1. Unicycler *(Note: Best for hybrid assemby but can assemble long and short reads)*
##### For long reads:
```{shell}
unicycler -l hp_trial_trimmed.fastq.gz --min_fasta_length 200  -o unicycler_assembled
```

##### For hybrid assembly
```{shell}
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -l long_reads.fastq.gz -o output_dir
```

##### For short reads
```{shell}
unicycler -1 short_reads_R1.fastq.gz -2 short_reads_R2.fastq.gz -o output_dir
```

#### 2. Canu 
```{shell}
canu -p prefix -d output_directory genomeSize=1.6m -nanopore sample_id_trimmed.fastq.gz 
```

#### 3. Flye
```{shell}
flye --nano-raw sample_id.fastq.gz --out-dir desired_folder_name --genome-size 1.6m
```
