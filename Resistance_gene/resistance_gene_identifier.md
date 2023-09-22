### RGI Resistance Gene Identifier
RGI can be used to predict resistomes from protein or nucleotide data based on homology and SNP models. Analyses can be performed via this web portal (20 Mb limit), via the command line, or via use of a Galaxy wrapper. The command line version can be obtained from the Download section of the CARD website. You can additionally install RGI from Conda or run RGI from Docker.

CARD is an ontology-centric knowledgebase on the molecular determinants of antibiotic resistance. By integrating a detailed controlled vocabulary, the Antibiotic Resistance Ontology (ARO), with ARG molecular sequences and mutation data, CARD is able to provide both reference set and software tools for guiding AMR research, particularly for ARG annotation and discovery from genomic and metagenomic data. uses the integrated information in CARD to predict resistome for genomic and metagenomic data, either using CARD’s website or as a command-line tool. Briefly, RGI algorithmically predicts AMR genes and mutations from submitted genomes using a combination of open reading frame prediction with Prodigal, sequence alignment with BLAST or DIAMOND, and curated resistance mutations included with the AMR detection model.

Github: https://github.com/arpcard/rgi

(Alcock BP, Huynh W, Chalil R, Smith KW, Raphenya AR, Wlodarski MA, Edalatmand A, Petkau A, Syed SA, Tsang KK, Baker SJC, Dave M, McCarthy MC, Mukiri KM, Nasir JA, Golbon B, Imtiaz H, Jiang X, Kaur K, Kwong M, Liang ZC, Niu KC, Shan P, Yang JYJ, Gray KL, Hoad GR, Jia B, Bhando T, Carfrae LA, Farha MA, French S, Gordzevich R, Rachwalski K, Tu MM, Bordeleau E, Dooley D, Griffiths E, Zubyk HL, Brown ED, Maguire F, Beiko RG, Hsiao WWL, Brinkman FSL, Van Domselaar G, McArthur AG. CARD 2023: expanded curation, support for machine learning, and resistome prediction at the Comprehensive Antibiotic Resistance Database. Nucleic Acids Res. 2023 Jan 6;51(D1):D690-D699. doi: 10.1093/nar/gkac920. PMID: 36263822; PMCID: PMC9825576.)

#### To run RGI via the command-line
Create Environment and Install RGI

Install mamba from mamba on your system
```{shell}
$ mamba create --name rgi --channel conda-forge --channel bioconda --channel defaults rgi
```
#### RGI usage
Download the latest AMR reference data from CARD:
```{shell}
wget https://card.mcmaster.ca/latest/data
tar -xvf data ./card.json
```

Load in Local or working directory:
```{shell}
rgi load --card_json /path/to/card.json --local
```
Note: The working directory must be changed to the place where rgi _data is stored.

Example

```{shell}
rgi load --card_json /home/anaconda3/envs/rgi/lib/python3.8/site-packages/app/_data/card.json --local
```
**Running a single sequence:**

Run the command below, specifying input and output directory (Strict mode)

```{shell}
rgi main --input_sequence /input_directory/assemby.fasta --output_file /output_directory/prefix --local --clean 
```
To run loose mode: Lower Identity

```{shell}
rgi main --input_sequence /path/to/nucleotide_input.fasta --output_file /path/to/output_file --local --clean --include_loose
```

**To run multiple files, set the loop as follow**

Paste thes scripts in a text editor and save as xxxxx.sh. Make sure to edit input and output directories.

```{shell}
#!/bin/bash

# Assuming your fasta files have the .fa extension
for input_file in input_file_directory/*.fa
do
    # Remove the extension and get the file name without path
    filename=$(basename "$input_file" .fa)

    # Construct the output file path
    output_file="/mnt/c/Users/Alain/Dropbox/PC/Desktop/mes_tuto/AST/RGI/${filename}"

    rgi main --input_sequence "$input_file" --output_file "$output_file" --local --clean
done
```

Add --include_loose to use the loose mode.

After activating rgi env and set the path the DB, type the command:

bash xxxx.sh

The result is given as a txt file. Convert it to xlsx using the command below. Ensure the packages and libraries are installed accordingly.

```{shell}
#!/bin/bash

for file in *.txt; do
    base=$(basename "$file" .txt)
    python3 -c "import pandas as pd; df = pd.read_csv('$file', sep='\t'); df['File'] = '$base'; df.to_excel('$base.xlsx', index=False)"
done
```
To concatenate multiple xlsx files, run the python script cat.py 