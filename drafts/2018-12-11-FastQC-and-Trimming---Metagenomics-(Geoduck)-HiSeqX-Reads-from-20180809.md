---
layout: post
title: FastQC and Trimming - Metagenomics (Geoduck) HiSeqX Reads from 20180809
date: '2018-12-11 15:47'
tags:
  - metagenomics
  - fastqc
  - multiqc
  - trimgalore
  - geoduck
  - Panopea generosa
  - jupyter
categories:
  - Miscellaneous
---
Steven tasked me with [assembling our geoduck metagenomics HiSeqX data](https://github.com/RobertsLab/resources/issues/508). The first part of the process is examining the quality of the sequencing reads, performing quality trimming, and then checking the quality of the trimmed reads. It's also possible (likely) that I'll need to run another round of trimming. The process is documented in the Jupyter Notebook linked below. After these reads are cleaned up, I'll transfer them over to our HPC nodes (Mox) and try assembling them.


Jupyter Notebook (GitHub):

- [20181211_swoose_gigas_mt_primer_design.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20181211_swoose_gigas_mt_primer_design.ipynb)

---

### RESULTS

Samples required two rounds of trimming:

1. Initial quality/adapter trimming.

2. Remove funky 5' 10bp from each read.

Now that the reads are cleaned, will transfer doubly-trimmed data to Mox for assembly.

---

Output folder:

- [20181211_metagenomics_fastqc_trimgalore/](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/)


---

Initial FastQC folder:

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_fastqc/](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_fastqc/)

MultiQC Report (HTML):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_fastqc/multiqc_report.html](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_fastqc/multiqc_report.html)


---

TrimGalore! folder (initial qualitry trim):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/)

Post-trimming FastQC folder (first round):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/20181211_metagenomics_trimmed_fastqc/](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/20181211_metagenomics_trimmed_fastqc/)

MultiQC Report (HTML):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/20181211_metagenomics_trimmed_fastqc/multiqc_report.html](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_01/20181211_metagenomics_trimmed_fastqc/multiqc_report.html)

---

TrimGalore! folder (second round, 10bp trim):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02)

Post-trimming FastQC folder (second round, 10bp trim):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02/20181211_metagenomics_trimmed_fastqc/](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02/20181211_metagenomics_trimmed_fastqc/)

MultiQC Report (HTML):

- [20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02/20181211_metagenomics_trimmed_fastqc/multiqc_report.html](http://gannet.fish.washington.edu/Atumefaciens/20181211_metagenomics_fastqc_trimgalore/20181211_metagenomics_trimgalore_02/20181211_metagenomics_trimmed_fastqc/multiqc_report.html)
