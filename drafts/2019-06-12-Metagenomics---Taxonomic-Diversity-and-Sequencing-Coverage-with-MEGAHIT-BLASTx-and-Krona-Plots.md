---
layout: post
title: Metagenomics - Taxonomic Diversity and Sequencing Coverage with MEGAHIT BLASTx and Krona Plots
date: '2019-06-12 11:00'
tags:
  - metagenomics
  - Panopea generosa
  - geoduck
  - blastx
  - krona
  - taxonomy
  - plots
categories:
  - Miscellaneous
---
After a meeting on this project around the middle of May, we decided to try various approaches to assessing the metagenome. One aspect was to add coverage sequencing coverage information to our BLASTx taxonomy visualizations. I used the MEGAHIT coverage info [from 20190327](https://robertslab.github.io/sams-notebook/2019/03/27/Metagenome-Assemblies-P.generosa-Water-Samples-Trimmed-HiSeqX-Data-Using-Megahit-on-Mox.html) and the subsequent BLASTx data [from 20190516](https://robertslab.github.io/sams-notebook/2019/05/16/Metagenomics-BLASTx-of-Individual-Water-Sample-MEGAHIT-Assemblies-on-Mox.html).

Briefly, I parsed out and joined the data to generate the appropriate input file needed for visualizations using [Krona Tools](https://github.com/marbl/Krona/wiki) and then ran the `ktImportTaxonomy` Krona Tools program. This is all detailed in the Jupyter Notebook below.


Jupyter Notebook (GitHub):

- [20190612_swoose_metagenomics_ind_coverage_krona.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190612_swoose_metagenomics_ind_coverage_krona.ipynb)

NBViewer for viewing notebook:

- [20190612_swoose_metagenomics_ind_coverage_krona](https://nbviewer.jupyter.org/github/RobertsLab/code/blob/master/notebooks/sam/20190612_swoose_metagenomics_ind_coverage_krona.ipynb)


---

#### RESULTS

Output folder:

- [20190612_metagenomics_ind_coverage_krona](https://gannet.fish.washington.edu/Atumefaciens/20190612_metagenomics_ind_coverage_krona/)

Krona Plots (HTML):

- [20190612_metagenomics_ind_coverage_krona/taxonomy.krona.html](https://gannet.fish.washington.edu/Atumefaciens/20190612_metagenomics_ind_coverage_krona/taxonomy.krona.html)


Example of Krona plot showing the Avg. score (i.e. the average of average sequencing coverage for a given taxonomic group):

![Example of Krona plot showing the Avg. score (i.e. the average of average sequencing coverage for a given taxonomic group)](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190612_metagenomics_blastx_cov_krona.png?raw=true)

---
