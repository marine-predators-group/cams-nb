---
layout: post
title: Genome Annotation - Pgenerosa_v074 a4 Using GenSAS
date: '2019-09-28 10:01'
tags:
  - GenSAS
  - geoduck
  - Panopea generosa
  - v074
  - Pgenerosa_v074
  - v074.a4
  - Panopea-generosa-vv0.74.a4
  - annotation
categories:
  - Geoduck Genome Sequencing
---



---

#### RESULTS

Output folder:

- [20190928_Pgenerosa_v074.a4_gensas_annotation/](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/)

Merged GFF (SwissProt IDs in Column 9 - from BLASTp and DIAMOND):

- [Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3)



BUSCO assessment (metazoa_odb9):

- 71.5% complete BUSCOs present in predicted genes

---

Feature counts:

```shell
awk 'NR>3 {print $3}' Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3 | sort | uniq -c

 236960 CDS
 236960 exon
  34947 gene
  38326 mRNA
1527155 repeat_region
      7 rRNA
  15514 tRNA

```

Individual feature GFFs were made with the following shell commands:

```shell
features_array=(CDS exon gene mRNA repeat_region rRNA tRNA)

input="Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3"

for feature in ${features_array[@]}
do
output="Panopea-generosa-vv0.74.a4.${feature}.gff3"
head -n 3 ${input} \
>> ${output}
awk -v feature="$feature" '$3 == feature {print}' ${input} \
>> ${output}
done
```

- [Panopea-generosa-vv0.74.a4.CDS.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.CDS.gff3)

- [Panopea-generosa-vv0.74.a4.exon.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.exon.gff3)

- [Panopea-generosa-vv0.74.a4.gene.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.gene.gff3)

- [Panopea-generosa-vv0.74.a4.mRNA.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.mRNA.gff3)

- [Panopea-generosa-vv0.74.a4.repeat_region.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.repeat_region.gff3)

- [Panopea-generosa-vv0.74.a4.rRNA.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.rRNA.gff3)

- [Panopea-generosa-vv0.74.a4.tRNA.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.tRNA.gff3)

---

SwissProt functional annotations (tab-delimited text):

- BLASTp
  - [Panopea-generosa-vv0.74.a4.5d951a9b74287-blast_functional.tab](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.5d951a9b74287-blast_functional.tab)
- DIAMOND
  - [Panopea-generosa-vv0.74.a4.5d951bcf45b4b-diamond_functional.tab](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.5d951bcf45b4b-diamond_functional.tab)

---

Pfam annotations (tab-delimited text):

- [Panopea-generosa-vv0.74.a4.5d951bd7b0381-pfam.tab](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.5d951bd7b0381-pfam.tab)


Grabbed the top 10 most abundant Pfam Accessions to see how things looked:

```shell
awk '{print $2}' Panopea-generosa-vv0.74.a4.5d951bd7b0381-pfam.tab | sort | uniq -c | sort -nr | head
```

| Feature Count | Pfam Accession | Pfam                                |
|---------------|----------------|-------------------------------------|
| 250           | PF07690.11     | major facilitator superfamily (MFS) |
| 213           | PF00643.19     | B-box zinc finger                   |
| 202           | PF00069.20     | Protein kinase domain               |
| 192           | PF00001.16     | Rhodopsin-like receptors            |
| 190           | PF12796.2      | Ankyrin repeat                      |
| 147           | PF00400.27     | WD40 repeat                         |
| 145           | PF00084.15     | Selectin                            |
| 135           | PF00067.17     | Cytochrome P450                     |
| 134           | PF00059.16     | C-type lectin                       |
| 133           | PF02931.18     | Ligand-gated ion channel            |

A couple of interesting things that I notice from this table:

1. This annotation eliminates the DNA transposition Pfams that were present in the [Panopea-generosa-vv0.74.a3 GenSAS annotation from 20190710](https://robertslab.github.io/sams-notebook/2019/07/10/Genome-Annotation-Pgenerosa_v074-Using-GenSAS.html)

2. Repeat families are still present, but now make up the majority of the most abundant Pfams.

3. Rhodopsin Pfam is still amongst the Top 10 most abundant Pfams!

---

InterProScan annotations (tab-delimited text):

- [Panopea-generosa-vv0.74.a4.5d951bd337e9d-interproscan.tab](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/Panopea-generosa-vv0.74.a4.5d951bd337e9d-interproscan.tab)

  - Contains gene ontology (GO) terms

---

Project Summary file (TEXT):

- [t_5d25021b0d20b-5d9637f372b5d-publish-project-summary.txt](https://gannet.fish.washington.edu/Atumefaciens/20190928_Pgenerosa_v074.a4_gensas_annotation/t_5d25021b0d20b-5d9637f372b5d-publish-project-summary.txt)

```shell
=================================
 Project Summary
---------------------------------
# Project Information
  Project Name         : Pgenerosa_v074
  Owner                : kubu4
  Create Date          : 2019-07-09 14:07:39

# Project Properties
  Genus                : Panopea
  Species              : generosa
  Project Type         : invertebrate
  Prefix               : PGEN_
  Common Name          : Pacific geoduck
  Genetic Code         : Standard Code

# Input FASTA
  Filename           : Pgenerosa_v074.fa
  Filesize           : 913.68 MB
  Number of Sequence : 18

=================================
 Job Information
---------------------------------
# Official Gene Set
  >PASA Refinement BRAKER
  - version : 2.3.3
  - Transcripts FASTA file : Trinity.fasta

  # The source Job of the refinement job
    >BRAKER-01
    - version : 2.1.0
    - BAM File :


# The consensus mask Job
  >Masked Repeat Consensus

  # The source jobs for consensus mask job
    >RepeatMasker
    >RepeatModeler

  # Family copy number summary
    Family	Copy Numbers
    DNA	675
    DNA/Academ	1327
    DNA/Crypton	344
    DNA/Ginger	130
    DNA/Kolobok-T2	141
    DNA/Maverick	942
    DNA/MuLE-MuDR	201
    DNA/MuLE-NOF?	142
    DNA/P	167
    DNA/PIF-Harbinger	227
    DNA/RC	587
    DNA/Sola	508
    DNA/TcMar-Fot1	117
    DNA/TcMar-Mariner	6734
    DNA/TcMar-Tc1	3718
    DNA/hAT-Tip100	516
    DNA/hAT-hAT5	1037
    Type:DNA	17513
    LINE	883
    LINE/CR1	5204
    LINE/CR1-Zenon	14653
    LINE/I	980
    LINE/I-Nimb	1119
    LINE/L1	4031
    LINE/L1-Tx1	6620
    LINE/L2	8879
    LINE/L2-Hydra	113
    LINE/Penelope	1026
    LINE/RTE-X	21214
    Type:LINE	64722
    SINE/tRNA-Core-L2	41152
    Type:SINE	41152
    LTR/Caulimovirus	140
    LTR/DIRS	448
    LTR/Gypsy	1031
    LTR/Ngaro	343
    LTR/Pao	82
    Type:LTR	2044
    Type:EVERYTHING_TE	125431
    Type:Simple_repeat	19235
    Type:Unknown	1465471

# The functional Jobs on the OGS
  >Pfam
  - version : 1.6
  - E-value Sequence : 1
  - E-value Domain : 10

  >SignalP
  - version : 4.1
  - Organism group : euk
  - Method : best
  - D-cutoff for SignalP-noTM networks : 0.45
  - D-cutoff for SignalP-TM networks : 0.50
  - Minimal predicted signal peptide length : 10
  - Truncate to sequence length : 70

  >BLAST protein vs protein (blastp)
  - version : 2.7.1
  - Protein Data Set : SwissProt
  - Maximum HSP Distinace : 30000
  - Output type : tab
  - Matrix : BLOSUM62
  - Expect : 1e-8
  - Word Size : 3
  - Gap Open : 11
  - Gap Extend : 1

  >DIAMOND Functional
  - version : 0.9.22
  - Protein Data Set : SwissProt

  >InterProScan
  - version : 5.29-68.0
```
