
**After completion of prokka, create a new directory/folder and name it "ffn" and run the script copy.sh**

Note that the copy.sh and assembly results should be in same directory

Concatenate ffn files from ffn folder
```{shell}
cat *.ffn > combined_ffn.fasta #Go to that directory and concatenate all .ffn files into one file
```

### BLAST STEPS
#### 1. Install BLAST
Install blast and make different environments for prokka and blast
```{shell}
conda create -n blast
conda install -c bioconda blast 
```

#### 2. Make a blast database
```
makeblastdb -in combined_ffn.fasta -dbtype nucl -out db_trial -parse_seqids
```

-  in = "name_of_file"
-  dbtype = "type of database : nucl (nucleotide) or prot (protein)"
-  out = "name_of_the_database_folder"
-  set the file that will be the database 
-  parse_seqids = "Parse by Sequence ID"


#### 2. Run Blast
Put the query files (Reference seq/gene) into the same folder (if in other folder, don't forget to specify the path) and run blast

```{shell}
blastn -db db_trial -query cagA_26695.fasta -outfmt 6 -out cagAblast_fmt6 
```
Note: query = "reference gene (in this case cagA)", outfmt 6 = "oupt file format 6", cagAblast_fmt6 = "name of the output file"

#### 3. Make a list of -entry_batch 

```{shell}
cut -f 2 cagAblast_fmt6 > list_cagA
```
list_cagA = Output: Name of the entry batch

#### 4. Retrive the fasta files

```{shell}
blastdbcmd -db db_trial -entry_batch list_cagA -out cagA_trial.fasta
```

-  db = database "name of the database created"
-  entry_batch = "name of the list"
-  out = "output filename and extension as fasta"*
