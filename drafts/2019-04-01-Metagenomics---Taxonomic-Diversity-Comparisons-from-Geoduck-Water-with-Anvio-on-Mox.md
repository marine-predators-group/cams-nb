---
layout: post
title: Metagenomics - Taxonomic Diversity Comparisons from Geoduck Water with Anvio on Mox
date: '2019-04-01 14:44'
tags:
  - metagenomics
  - water
  - geoduck
  - Panopea generosa
  - anvio
  - mox
categories:
  - Miscellaneous
---


One of the many reasons [Anvi'o](http://merenlab.org/software/anvio/) seems like such a good choice for this are things like this:

![Anvio's screencap showing memory requirement and skull](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190404_metagenomics_pgen_anvio-01.png?raw=true)

By checking the SLURM output file, Anvi'o was showing that it was using 28 threads that required 478GB of memory, and since I was using a node in the coenv partition, I had insufficient memory (only 120GB)! Luckily, we have a 500GB node in the srlab partion. So, with some finagling I did the following in order to get this job to run faster (if I had left if running, it would have probably taken months to complete):

- killed Anvi'o job running on coenv node
- killed Maker job running on both srlab nodes
- started Anvi'o job running on srlab 500GB node
- queued Maker job on srlab nodes
  - This has built-in checkpointing so we continue where it left off once Anvi'o job completes!
