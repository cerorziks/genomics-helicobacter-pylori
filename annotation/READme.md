#RUNNING PROKKA AND BLAST

#PROKKA STEPS
##Create environment and install prokka
conda create -n myprokka
conda activate myprokka
conda install -c bioconda prokka

#Run prokka
##copy the fasta files into the directory with prokka.sh and copy.sh
bash prokka.sh 

##After completion of prokka, create a new folder and name it "ffn"
bash copy.sh

#BLAST STEPS
##Install BLAST
conda install -c bioconda blast

#Go to that directory and concatenate all .ffn files into one file
cat *.ffn > combined_ffn.fasta

#Make a database 
makeblastdb -in combined_ffn.fasta -dbtype nucl -out db_trial -parse_seqids

###in= name_of_file
###dbtype= type of database : nucl (nucleotide) or prot (protein)
###out= name_of_the_database_folder
###set the file that will be the database 
###parse_seqids= Parse by Sequence ID

#Put the query files (Reference seq/gene) into the same folder (if in other folder, dont forget to specify the path) and run blast
blastn -db db_trial  -query cagA_26695.fasta -outfmt 6 -out cagAblast_fmt6
#Note: outfmt 6= oupt file format 6, cagAblast_fmt6=name of the output file

#Make the list of -entry_batch
cut -f 2 cagAblast_fmt6 > list_cagA
#Note: list_cagA is the name of the entry batch

#retrive the fasta files 
blastdbcmd -db db_trial -entry_batch list_cagA -out cagA_trial.fasta
