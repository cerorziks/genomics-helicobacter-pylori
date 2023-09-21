## Genome Annotation: Helicobacter pylori (PROKKA AND BLAST)

### PROKKA STEPS

#### 1. Creating environment and install prokka 
```{shell}
conda create -n myprokka conda 
activate myprokka #activate environment
conda install -c bioconda prokka #install prokka
```

#### Run the script "prokka.sh" to annotate
```{shell}
bash prokka.sh #to run prokka
```

#### 3. Copy the fasta files into the directory with prokka.sh and copy.sh bash prokka.sh
#### 4. After completion of prokka, create a new folder and name it "ffn" bash copy.sh

### BLAST STEPS
#### 1. Install BLAST and combine ffn files from prokka result
```{shell}
conda install -c bioconda blast #install blast, make different environments for prokka and blast

cat *.ffn > combined_ffn.fasta #Go to that directory and concatenate all .ffn files into one file

makeblastdb -in combined_ffn.fasta -dbtype nucl -out db_trial -parse_seqids
```

*in = "name_of_file"* 
*dbtype = "type of database : nucl (nucleotide) or prot (protein)"* 
*out = "name_of_the_database_folder"*
*set the file that will be the database* 
*parse_seqids = "Parse by Sequence ID"*


#### 2. Run Blast
Put the query files (Reference seq/gene) into the same folder (if in other folder, don't forget to specify the path) and run blast

```{shell}
blastn -db db_trial -query cagA_26695.fasta -outfmt 6 -out cagAblast_fmt6 
```
*Note: query = "reference gene (in this case cagA)", outfmt 6 = "oupt file format 6", cagAblast_fmt6 = "name of the output file"*

#### 3. Make a list of -entry_batch 

```{shell}
cut -f 2 cagAblast_fmt6 > list_cagA
```
*list_cagA = Output: Name of the entry batch*

#### 4. Retrive the fasta files

```{shell}
blastdbcmd -db db_trial -entry_batch list_cagA -out cagA_trial.fasta
```

*db = database ("name of the database created"), entry_batch = "name of the list", out = "output filename and extension as fasta"*
