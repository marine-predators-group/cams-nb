---
layout: post
title: Primer Design - Geoduck Vitellogenin using Primer3
date: '2018-11-29 14:06'
tags:
  - geoduck
  - Panopea generosa
  - vitellogenin
  - Primer3
  - EMBOSS
  - PrimerSearch
  - Jupyter
categories:
  - Miscellaneous
---
In preparation for designing primers for [developing a geoduck vitellogenin qPCR assay](https://github.com/RobertsLab/resources/issues/491), I [annotated a _de novo_ geoduck transcriptome assembly](https://robertslab.github.io/sams-notebook/2018/11/21/Annotation-Geoduck-Transcritpome-with-TransDecoder.html) last week. Next up, identify vitellogenin genes, design primers, confirm their specificity, and order them!

All of this was done in a Jupyter Notebook on my computer (Swoose).


Jupyter notebook (GitHub):

- [20181128_swoose_geoduck_vitellogenin_analysis.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20181128_swoose_geoduck_vitellogenin_analysis.ipynb)

Annoated transcriptome FastA (271MB):

- [20181121_geo_transdecoder/20180827_trinity_geoduck.fasta.transdecoder.cds](http://gannet.fish.washington.edu/Atumefaciens/20181121_geo_transdecoder/20180827_trinity_geoduck.fasta.transdecoder.cds)

Although everything is explained pretty well in the Jupyter Notebook, here's the brief rundown of the process:

1. Download FastA file.

2. Split into individual FastA files for each sequence (used [pyfaidx v0.5.5.2](https://github.com/mdshw5/pyfaidx))

3. Identify sequences (in original FastA file, not individual files) annotated as vitellogenin.

4. Design primers on best vitellogenin match (based on TransDecoder score and BLASTp e-values) using Primer3.

5. Confirm primer specificity using [EMBOSS](http://emboss.sourceforge.net/download/)(v6.6.0) [primersearch tool](http://emboss.sourceforge.net/apps/cvs/emboss/apps/primersearch.html) to check all individual sequence files for possible matches.
