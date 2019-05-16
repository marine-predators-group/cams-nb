---
layout: post
title: Metagenomics - BLASTx of Individual Water Sample MEGAHIT Assemblies on Mox
date: '2019-05-16 14:47'
tags:
  - metagenomics
  - Panopea generosa
  - geoduck
  - mox
  - blastx
categories:
  - Miscellaneous
---
After a meeting on this project yesterda, we decided to try a few things to continue with various approaches to assessing the metagenome. One of the approaches is to run BLASTx on the individual water sample MEGAHIT assemblies [from 20190327 ](https://robertslab.github.io/sams-notebook/2019/03/27/Metagenome-Assemblies-P.generosa-Water-Samples-Trimmed-HiSeqX-Data-Using-Megahit-on-Mox.html) and obtain taxonomy info for them, so that's what I did here.

Samples breakdown like so, for reference:

- pH=7.1: MG3, MG6, MG7

- pH=8.2: MG1, MG2, MG5

SBATCH script (GitHub):

- [20190516_metagenomics_pgen_blastx.sh]()

<pre><code>

</code></pre>

---

#### RESULTS

Output folder:

- [20190516_metagenomics_pgen_blastx](http://gannet.fish.washington.edu/Atumefaciens/20190516_metagenomics_pgen_blastx)
