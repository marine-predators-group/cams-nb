---
layout: post
title: RepeatMasker - Pgenerosa_v070 for Transposable Element ID on Roadrunner
date: '2019-08-06 12:39'
tags:
  - Panopea generosa
  - geoduck
  - Pgenerosa_v070
  - v070
  - roadrunner
  - repeatmasker
  - TE
  - transposable elements
categories:
  - Geoduck Genome Sequencing
---
Continuing our various attempts at annotating our geoduck genome assemblies, I will be re-annotating our Pgenerosa_v070 (see [Genome Resources GitHub wiki for deets](https://github.com/RobertsLab/resources/wiki/Genomic-Resources)) and realized I hadn't run RepeatMasker on this assembly previously. Running RepeatMasker will generate a GFF that I can supply to MAKER to aid in repeats identification.

I ran RepeatMasker 4.07 on Roadrunner (Apple Xserve running Ubuntu 16.04LTS) using the "all" species setting.

All of it is detailed in this Jupyter Notebook (GitHub):

- [20190806_roadrunner_Pgenerosa_v070_TEs_repeatmasker.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190806_roadrunner_Pgenerosa_v070_TEs_repeatmasker.ipynb)


---

#### RESULTS

Output folder:

- []()
