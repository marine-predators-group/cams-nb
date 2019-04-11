---
layout: post
title: Data Management - Whole Genome Bisulfite Sequencing Data from Genewiz Received
date: '2019-04-08 12:37'
tags:
  - Panopea generosa
  - geoduck
  - Pacific oyster
  - Crassostrea gigas
  - WGBS
  - BSseq
  - bisulfite
categories:
  - Miscellaneous
---

Received the WGBS data from Genewiz that were [sent to Genewiz for whole genome bisulfite sequencing on 20190207](https://robertslab.github.io/sams-notebook/2019/02/07/Samples-Submitted-Robertos-C.gigas-DNA-for-Whole-Genome-Bisulfite-Sequencing-Genewiz.html). These were from:

- Roberto's _C.gigas_ samples

| Sample_ID | Family | DNA_tube_label |
|-----------|--------|----------------|
| 0501      | 5      | 501            |
| 3501      | 35     | 3501           |
| 5201      | 52     | 5201           |
| 5901      | 59     | 5901           |
| 0502      | 5      | 5 3 A          |
| 3502      | 35     | 6 susc. 5 D3   |
| 5202      | 52     | 52 4 A         |
| 5902      | 59     | 59 11B         |
| 0503      | 5      | 05 30          |
| 3503      | 35     | 35 30          |
| 5203      | 52     | 52 30          |
| 5903      | 59     | 59 30          |

- [Yaamini's _C.gigas_](https://yaaminiv.github.io/WGBS-Samples/) samples

- [Shelly's _P.generosa_ samples](https://shellytrigg.github.io/38th-post/)

Transferred data to [nightingales/C_gigas](http://owl.fish.washington.edu/nightingales/C_gigas/) or [nightingales/P_generosa](http://owl.fish.washington.edu/nightingales/P_generosa/) and verified MD5 checksums. Have added list of files to [nightingales spreadsheet](https://docs.google.com/spreadsheets/d/1_XqIOPVHSBVGscnjzDSWUeRL7HUHXfaHxVzec-I-8Xk/edit#gid=0)(Google Sheet).

Also, of importance, are trimming guidelines for these sequences. [Hollie contacted Genewiz about their library prep](https://genefish.slack.com/archives/CD9M5LSFK/p1552084666004400) and learned they use the [Accel-NGS Methyl-Seq DNA Library Kit (Swift)](https://swiftbiosci.com/products/accel-ngs-methyl-seq-dna-library-kit/accel-ngs-methyl-seq-dna-library-kit/). Swift provides a [technical bulletin on trimming](https://swiftbiosci.com/wp-content/uploads/2016/09/16-0853-Tail-Trim-TN.pdf) and indicates the following:

> Trimming 10 bases from the beginning of both R1 and R2 _following_ adapter trimming eliminates the majority of Adaptase tails.
