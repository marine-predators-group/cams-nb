---
layout: post
title: RepeatMasker - Pgenerosa_v074 for Transposable Element ID on Roadrunner
date: '2019-06-26 12:07'
tags:
  - repeatmasker
  - Panopea generosa
  - geoduck
  - v074
  - TE
  - roadrunner
  - jupyter
categories:
  - Miscellaneous
---
[Yesterday (20190625)](https://robertslab.github.io/sams-notebook/2019/06/25/Data-Wrangling-FastA-Subsetting-of-Pgenerosa_v070.fa-Using-samtools-faidx.html) I generated a subset of the first 18 FastA sequences from the [Pgenerosa_v070.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v070.fa) file. This subset has been designated as Pgenerosa_v074 by Steven. It's avilable on our Genomic Resources wiki:

- [Pgenerosa_v074.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v074.fa)

Steven has asked me to generate a transposable elements (TE) GFF to accompany this assembly. Additionally, he's asked to annotate this assembly using MAKER - this will be detailed in another notebook entry at some point.

Anyway, I ran RepeatMasker 4.07 on Roadrunner (Apple Xserve running Ubuntu 16.04LTS) using the "all" species setting.

All of it is detailed in the Jupyter Notebook (GitHub):

- [20190626_roadrunner_Pgeneros_v074_TEs_repeatmasker.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190626_roadrunner_Pgeneros_v074_TEs_repeatmasker.ipynb)

---

#### RESULTS

Output folder:

- [20190626_Pgenerosa_v074_repeatmasker_all](https://gannet.fish.washington.edu/Atumefaciens/20190626_Pgenerosa_v074_repeatmasker_all/)

Summary table (text):

- [Pgenerosa_v074.fa.tbl](https://gannet.fish.washington.edu/Atumefaciens/20190626_Pgenerosa_v074_repeatmasker_all/Pgenerosa_v074.fa.tbl)

Output GFF:

- [Pgenerosa_v074.fa.out.gff](https://gannet.fish.washington.edu/Atumefaciens/20190626_Pgenerosa_v074_repeatmasker_all/Pgenerosa_v074.fa.out.gff)

---

#### SUMMARY TABLE

```

```
