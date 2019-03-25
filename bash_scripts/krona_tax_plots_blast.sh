#!/bin/env bash

# Bash script for creating Krona plot of metagenomics taxonomies from BLAST outputs.

# BLAST output format is expected to be: "6 std staxids"

# Input/output files
blast_out="blastp.outfmt6"
krona_out="krona_megahit_MGM_blastp.html"
krona_tax_list="krona_tax.lst"

# Programs
krona="/home/sam/programs/KronaTools-2.7/bin/ktImportTaxonomy"

## Extract NCBI taxon IDs from BLAST output
### Set ';' and tab as field delimiters. Prevents issues with taxon ID column having multiple entries for multi-strain matching
### Prints a tab-delimited ouptut file containing the query ID and the taxon ID
awk -F'[;\t]' '{print $1 "\t" $13}' ${blast_out} > ${krona_tax_list}

## Create Krona plot, specifying output filename
${krona} \
-o ${krona_out} \
${krona_tax_list}
