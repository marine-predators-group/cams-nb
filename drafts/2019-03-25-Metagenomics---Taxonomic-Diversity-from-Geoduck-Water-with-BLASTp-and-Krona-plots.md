---
layout: post
title: Metagenomics - Taxonomic Diversity from Geoduck Water with BLASTp and Krona plots
date: '2019-03-25 15:15'
tags:
  - metagenomics
  - Panopea generosa
  - geoduck
  - blastp
  - krona
  - plot
categories:
  - Miscellaneous
---

[Megahit assembly notebook](https://robertslab.github.io/sams-notebook/2019/01/02/Metagenome-Assembly-P.generosa-Water-Sample-HiSeqX-Data-Using-Megahit.html) and [MetaGeneMark gene prediction notebook](https://robertslab.github.io/sams-notebook/2019/01/03/Gene-Prediction-HiSeqX-Metagenomics-from-Geoduck-Water-Using-MetaGeneMark-on-Mox.html)

[GitHub Issue](https://github.com/RobertsLab/resources/issues/547)

Jupyter Notebook (GitHub):

- [20190321_swoose_metagnomics_pgen_blastp_ncbi-sp-v5-db.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190321_swoose_metagnomics_pgen_blastp_ncbi-sp-v5-db.ipynb)


---

#### RESULTS

Output folder:

- [20190321_metagenomics_pgen_blastp/](http://gannet.fish.washington.edu/Atumefaciens/20190321_metagenomics_pgen_blastp/)


- Interactive Krona plots (HTML):

- [20190321_metagenomics_pgen_blastp/krona_megahit_MGM_blastp.html](http://gannet.fish.washington.edu/Atumefaciens/20190321_metagenomics_pgen_blastp/krona_megahit_MGM_blastp.html)

As a brief overview, the initial [Megahit assembly](https://robertslab.github.io/sams-notebook/2019/01/02/Metagenome-Assembly-P.generosa-Water-Sample-HiSeqX-Data-Using-Megahit.html) generated:

- 2,276,153 contigs.

[MetaGeneMark](https://robertslab.github.io/sams-notebook/2019/01/03/Gene-Prediction-HiSeqX-Metagenomics-from-Geoduck-Water-Using-MetaGeneMark-on-Mox.html) predicted:

- 3,296,610 genes.

BLASTp resulted in:

- 1,346,325 SwissProt matches

The Krona plot provides a pretty nice way to view the breakdown of the data and, as such, I won't provide a written summary of how it all shakes out. 

Next, for curiosity sake, I'll run BLASTn and see how things compare.
