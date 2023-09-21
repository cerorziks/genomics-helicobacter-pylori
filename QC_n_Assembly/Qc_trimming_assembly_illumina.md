### Quality Check, Adapter & Barcode trimming and Genome assembly

#### 1. FastQC: To check the quality of the read
Create environment and install FastQC
```{shell}
conda create -n FastQC
conda install -c bioconda fastqc
```
Run FastQC
```{shell}
fastqc *.fastq.gz -o FastQC_result
```
#### 2. Trimming Adapter/barcode sequences
Package: Trimmomatic

Installation
```{shell}
conda create -n trimmomatic
conda install -c bioconda trimmomatic
```
To run the program 
```{Shell}
trimmomatic PE -phred33 Sample_ID_R1_001.fastq.gz Sample_ID_R2_001.fastq.gz Sample_ID_R1_paired.fq.gz Sample_ID_R1_unpaired.fq.gz Sample_ID_R2_paired.fq.gz Sample_ID_R2_unpaired.fq.gz ILLUMINACLIP:/Nextera_directory/NexteraPE-PE.fa:2:30:10 SLIDINGWINDOW:4:30
```
*Note: This file "NexteraPE-PE.fa:2:30:10" must be in the same directory with sequences to be trimmed. For each input fastq.gz files, make output into two separate paired and unpaired files*

Paired reads that pass the quality thresholds will be written to `_paired` files, while unpaired reads will be written to `_unpaired` files. 

#### 3. Assembly
Package/Software: SPAdes

Installation
```{shell}
conda create -n spades
conda install -c bioconda spades
```

​A complete command line for using Trimmomatic typically looks something like this

```{shell}
java -jar trimmomatic-0.39.jar PE input_forward.fastq.gz input_reverse.fastq.gz output_forward_paired.fastq.gz output_forward_unpaired.fastq.gz output_reverse_paired.fastq.gz output_reverse_unpaired.fastq.gz
ILLUMINACLIP:adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```

Here's what each part does: 
- `java -jar trimmomatic-0.39.jar`: runs the Trimmomatic program using Java. 
- `PE`: Indicates that we are working with paired-end reads. 
- input files containing the forward and reverse reads in FASTQ format: `input_forward.fastq.gz` and `input_reverse.fastq.gz`: 
- output files: `output_forward_paired.fastq.gz`, `output_forward_unpaired.fastq.gz`, `output_reverse_paired.fastq.gz`, and `output_reverse_unpaired.fastq.gz`. 
- `ILLUMINACLIP:adapters.fa:2:30:10`: Specifies adapter trimming. 
`adapters.fa` is a file containing adapter sequences. 
The numbers `2:30:10` denote the parameters for the trimming: seed mismatches, palindrome clip threshold, and simple clip threshold. 
- `LEADING:3`: Removes low-quality bases from the start of a read until the base quality is 3 or higher. 
- `TRAILING:3`: Removes low-quality bases from the end of a read until the base quality is 3 or higher. 
- `SLIDINGWINDOW:4:15`: Performs a sliding window trimming. It scans the read with a 4-base wide window and cuts when the average quality drops below 15. 
- `MINLEN:36`: Discards reads that are shorter than 36 bases after all trimming steps. 

- **Seed Mismatches**: - This pa​rameter determines how many initial bases of a read match against the adapter sequence for the trimming to be initiated. - For example, if you set it to 2, it means that at least the first 2 bases of a read should match with the adapter sequence for trimming to start. 
- **Palindrome Clip Threshold**: - This threshold is used for "palindrome" adapter removal, which means removing sequences where the read is present in its reverse complement form. - For example, if you have the adapter sequence "AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC" and its reverse complement "GTGACTGGAGTTCAGACGTGTGCTCTTCCGATCT", and you set this threshold to 30, it means that if the first 30 bases of a read match either the adapter sequence or its reverse complement, they will be removed. 
- **Simple Clip Threshold**: - This is used for "simple" adapter removal, which means removing sequences where the read is present in its original form. - It functions similarly to the palindrome clip threshold, but applies to cases where the adapter is not a palindrome. In summary, these parameters help Trimmomatic identify adapter sequences in your reads. The "Seed Mismatches" parameter sets the initial matching criteria, while the "Palindrome Clip Threshold" and "Simple Clip Threshold" determine how many bases in a read need to match the adapter sequence before trimming occurs. These parameters are crucial for effectively removing adapter contamination from sequencing data.


To assemble a single sample

```{python}
spades.py -1 sample_id_R1_paired.fq.gz -2 sample_id_R2_paired.fq.gz --careful -o /outputdirectory
```
Example

```{python}
spades.py -1 Hp_mutant_R1_paired.fastq.gz -2 Hp_mutant_R2_paired.fastq.gz --careful -o /home/trial7/raw_data/trimmed/assembly
```
#### 4. Assembly Quality Check
Package/Software: QUAST

Installation
```{shell}
conda create -n quast #creating environment
conda install -c bioconda quast #installation of QUAST
```
To run Quast
```
quast -o quast_QC -r /output_directory_of_Hp_26695.fasta assembled_contig.fasta
```
- -o is the output name
- -r is the reference directory

Note: 
- Input = Assembled contigs in fasta format
- Use *.fasta  as input to do multiple samples
- Run DFAST to check for contamination