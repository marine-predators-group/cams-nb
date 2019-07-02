---
layout: post
title: Transcriptome Annotation - Geoduck Gonad with Transdecoder on Mox
date: '2019-06-27 15:20'
tags:
  - gonad
  - transdecoder
  - annotation
  - geoduck
  - Panopea generosa
  - mox
categories:
  - Miscellaneous
---

Used Transdecoder to identify open reading frames (ORFs) for use in [annotating Pgenerosa_v074 genome assembly](https://github.com/RobertsLab/resources/issues/707). Relies on BLASTp, Pfam, and HMM scanning to ID ORFs.

Trinity notebook:

- [20190409_trinity_geoduck_gonad_RNAseq](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Gonad-HiSeq-and-NovaSeq-Data-on-Mox.html)

SBATCH script (GitHub):

- [20190627_transdecoder_geoduck_gonad_RNAseq.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190627_transdecoder_geoduck_gaond_RNAseq.sh)

```shell

```

---

#### RESULTS

Run time:

![Screencap of Mox Transdecoder run time](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190627_transdecoder_pgen_gonad_runtime.png?raw=true)

Output folder:

- [20190627_transdecoder_geoduck_gonad_RNAseq/](https://gannet.fish.washington.edu/Atumefaciens/20190627_transdecoder_geoduck_gonad_RNAseq/)

CDS FastA:

- [20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.cds](https://gannet.fish.washington.edu/Atumefaciens/20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.cds)

Peptide FastA:

- [20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.pep](https://gannet.fish.washington.edu/Atumefaciens/20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.pep)

BED file:

- [20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.bed](https://gannet.fish.washington.edu/Atumefaciens/20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.bed)

GFF file:

- [20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.gff3](https://gannet.fish.washington.edu/Atumefaciens/20190627_transdecoder_geoduck_gonad_RNAseq/Trinity.fasta.transdecoder.gff3)
