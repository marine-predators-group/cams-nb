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

- []()

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
