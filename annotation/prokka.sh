#! /bin/bash
set -e
set -u
set -o pipefail

#for i in *.fasta 
#do 
#	prokka $i --outdir $(basename -s .fasta $i) --prefix $(basename -s .fasta $i) --locustag $(basename -s .fasta $i) 
#done

#for i in *.fna
#do 
#	prokka $i --outdir $(basename -s .fna $i) --prefix $(basename -s .fna $i) --locustag $(basename -s .fna $i) 
#done

for i in *.fasta ; do prokka $i --outdir $(basename -s .fasta $i) --prefix $(basename -s .fasta $i) --locustag $(basename -s .fasta $i); done
