---
layout: post
title: Data Wrangling - Olurida_v081 UTR GFFs and Intergenic, Intron BED files
date: '2019-12-14 09:04'
tags:
  - Ostrea lurida
  - Olympia oyster
  - intron
  - UTR
  - Olurida_v081
categories:
  - Miscellaneous
---
After a meeting last week, we realized we needed to update the [paper-oly-mbdbs-gen GitHub repo](https://github.com/sr320/paper-oly-mbdbs-gen/tree/master/genome-features) with the most current versions of feature files we had.

As part of that, we needed a new intron GFF file generated. I also realized that the output from the [MAKER annotation from 20190709]
(https://robertslab.github.io/sams-notebook/2019/07/09/Genome-Annotation-Olurida_v081-with-MAKER-and-Tissue-specific-Transcriptomes-on-Mox.html) actually has 3'/5' UTR features, so I decided to separate those out and create separate GFFs for them, as well.

The process was performed in the following Jupyter Notebook (GitHub):

- [20191214_olur_genome_feature_and_intron_splitting.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20191214_olur_genome_feature_and_intron_splitting.ipynb)

---

#### RESULTS

Output folder:

- []()
