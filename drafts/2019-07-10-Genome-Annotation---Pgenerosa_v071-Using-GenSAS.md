---
layout: post
title: Genome Annotation - Pgenerosa_v071 Using GenSAS
date: '2019-07-10 09:28'
tags:
  - GenSAS
  - geoduck
  - Panopea generosa
  - annotation
	- Pgenerosa_v071
	- v071.a2
categories:
  - Geoduck Genome Sequencing
---
In our various attempts to get the _Panopea generosa_ genome annotated in such a manner that we're comfortable with (the previous annotation attempts we're lacking any annotations in almost all of the largest scaffolds, which didn't seem right), Steven stumbled across [GenSAS](https://www.gensas.org/gensas), a web/GUI-based genome annotation program, so we gave it a shot.

This version of the genome annotation will be referred to as:

- Panopea-generosa-vv0.71.a2

I uploaded the following to the GenSAS website to potentially use as "evidence files":

#### Transcriptome FastA files (links to notebook entries):
- [singular transcriptome](https://robertslab.github.io/sams-notebook/2018/09/04/transcriptome-assembly-geoduck-rnaseq-data.html)
- [ctenidia](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Ctenidia-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [gonad](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Gonad-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [heart](https://robertslab.github.io/sams-notebook/2019/02/15/Transcriptome-Assembly-Geoduck-Tissue-Specific-Assembly-Heart.html)
- [EPI99 (larvae)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Larvae-Day5-EPI99-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [EPI115 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI115-with-HiSeq-Data-on-Mox.html)
- [EPI116 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI116-with-HiSeq-Data-on-Mox.html)
- [EPI123 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI123-with-HiSeq-Data-on-Mox.html)
- [EPI124 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI124-with-HiSeq-and-NovaSeq-Data-on-Mox.html)


#### TransDecoder protein FastA files (links to notebook entries)
- [singular proteome](https://robertslab.github.io/sams-notebook/2018/11/21/Annotation-Geoduck-Transcritpome-with-TransDecoder.html)
- [ctenidia](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Ctenidia-with-Transdecoder-on-Mox.html)
- [EPI99 (larvae)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Larvae-Day5-EPI99-with-Transdecoder-on-Mox.html)
- [EPI115 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Super-Low-OA-EPI115-with-Transdecoder-on-Mox.html)
- [EPI116 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Super-Low-OA-EPI116-with-Transdecoder-on-Mox.html)
- [EPI123 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Ambient-OA-EPI123-with-Transdecoder-on-Mox.html)
- [EPI124 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Ambient-OA-EPI124-with-Transdecoder-on-Mox.html)
- [gonad](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Gonad-with-Transdecoder-on-Mox.html)
- [heart](https://robertslab.github.io/sams-notebook/2019/03/18/Transcriptome-Annotation-Geoduck-Heart-with-Transdecoder-on-Mox.html)

#### Repeats Files
- [RepeatModeler library](https://robertslab.github.io/sams-notebook/2019/06/26/RepeatModeler-Pgenerosa_v074-for-MAKER-Annotation-on-Emu.html)

---

#### RESULTS

This took way longer than I was expecting! This took nearly an entire month (the majority of that time was running Augustus _ab initio_ gene prediction, which took ~3 weeks):

![v071 GenSAS project summary processes and runtimes screencap](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190710_gensas_pgen-071_runtimes.png?raw=true)

Output folder:

- [20190710_Pgenerosa_v071_gensas_annotation/](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/)

Feature counts:

```shell
awk 'NR>3 { print $3 }' Panopea-generosa-v1.0.a2-merged-2019-08-29-15-28-54.gff3 | sort | uniq -c

264153 CDS
264153 exon
 56167 gene
 56167 mRNA
```

BUSCO assessment:

- 80.7% complete BUSCOs present in predicted genes


Individual feature GFFs were made with the following shell commands:


```shell
features_array=(CDS exon gene mRNA)

for feature in ${features_array[@]}
do
output="Panopea-generosa-v1.0.a2.${feature}.gff3"
input="Panopea-generosa-v1.0.a2-merged-2019-08-29-15-28-54.gff3"
head -n 3 Panopea-generosa-v1.0.a2-merged-2019-08-29-15-28-54.gff3 \
>> ${output}
awk -v feature="$feature" '$3 == feature {print}' ${input} \
>> ${output}
done
```

- [Panopea-generosa-vv0.71.a2CDS.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-vv0.71.a2.CDS.gff3)

- [Panopea-generosa-vv0.71.a2exon.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-vv0.71.a2.exon.gff3)

- [Panopea-generosa-vv0.71.a2gene.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-vv0.71.a2.gene.gff3)

- [Panopea-generosa-vv0.71.a2mRNA.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-vv0.71.a2.mRNA.gff3)


SwissProt functional annotations (tab-delimited text):

- BLASTp
  - [Panopea-generosa-v1.0.a2.5d66e5b736200-blast_functional.tab](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-v1.0.a2.5d66e5b736200-blast_functional.tab)

- DIAMOND
  - [Panopea-generosa-v1.0.a2.5d66e5cca9bdd-diamond_functional.tab](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-v1.0.a2.5d66e5cca9bdd-diamond_functional.tab)



Pfam annotations (tab-delimited text):

- [Panopea-generosa-v1.0.a2.5d65aa832a1bf-pfam.tab](https://gannet.fish.washington.edu/Atumefaciens/20190710_Pgenerosa_v071_gensas_annotation/Panopea-generosa-v1.0.a2.5d65aa832a1bf-pfam.tab)

Grabbed the top 10 most abundant Pfam Accessions to see how things looked:

| Feature Count | Pfam Accession | Pfam                     |
|---------------|----------------|--------------------------|
| 364           | PF00643.19     | B-box zinc finger        |
| 293           | PF07690.11     | Major facilitator family |
| 228           | PF00001.16     | Rhodopsin-like receptors |
| 220           | PF12796.2      | Ankyrin repeat           |
| 209           | PF00651.26     | BTB/POZ domain           |
| 206           | PF00069.20     | Protein kinase domain    |
| 180           | PF00067.17     | Cytochrome P450          |
| 175           | PF02931.18     | Ligand-gated ion channel |
| 174           | PF00400.27     | WD40 repeat              |
| 174           | PF00059.16     | C-type lectin            |

A rhodopsin protein family appears in the Top 10 most abundant Pfams?! Proteins in this family are involved in light detection...
