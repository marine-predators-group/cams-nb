---
layout: post
title: Data Analysis - C.virginica MBD Sequencing Coverage
date: '2019-04-18 13:54'
tags:
  - Crassostrea virginica
  - Eastern oyster
  - MBD
  - Bismark
  - jupyter
categories:
  - Miscellaneous
---
A while ago, Steven tasked me with assessing some questions related to the sequencing coverage we get doing MBD-BSseq in this [GitHub issue](https://github.com/RobertsLab/resources/issues/609). At the heart of it all was really to try to get an idea of how much usable data we actually get when we do an MBD-BSseq project. Yaamini happened to have done an MBD-BSseq project relatively recently, and it's one she's actively working on analyzing, so we went with that data set.

Data was initially trimmed:

- [20180411 TrimGalore and FastQC](https://robertslab.github.io/sams-notebook/2018/04/11/trimgalorefastqcmultiqc-trim-10bp-53-ends-c-virginica-mbd-bs-seq-fastq-data.html)

Subsequently, the data was concatenated, subset, and aligned using Bismark:

- [20190313 Bismark alignment subsetting](https://robertslab.github.io/sams-notebook/2019/03/13/Methylation-Analysis-C.virginica-Gonad-MBD-with-Varying-Read-Subsets-with-Bismark-on-Mox.html)


Today, I finally found the time to dedicate to evaluating alignment coverage of each of the Bismark sequence subsets. It was done in a Jupyter Notebook:

- [20190418_cvir_mbd_coverage_comparison.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190418_cvir_mbd_coverage_comparison.ipynb)

---

#### RESULTS
