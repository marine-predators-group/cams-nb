---
layout: post
title: Metagenomics Annotation - P.generosa Water Samples with MEGAN6
date: '2019-10-14 09:22'
tags:
  - MEGAN6
  - metagenomics
  - Panopea generosa
  - geoduck
categories:
  - Miscellaneous
---
After running [DIAMOND BLASTx and MEGANIZER on these samples on 20190925](https://robertslab.github.io/sams-notebook/2019/09/25/Metagenomics-Annotation-P.generosa-Water-Samples-Using-DIAMOND-BLASTx-on-Mox.html) to assess taxonomy info, I began the analyses/visualization of this data with (MEGAN6)[https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/megan6/].


Initially, I tried to import all of the Meganized DAA files, but ran in to  problems.

After running for an entire day, my hard drive ran out of space! Turns out, each of the MEGAN6 files generated are going to be HUGE:

![Screencap showing 178GB MEGAN6 file size for a single sample](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20191014_metagenomics_MEGAN6_filesize.png?raw=true)

If each sample is going to generate a 178GB (or larger?) file, I tried to run this analysis directly on Gannet, as my computer's HDD won't have enough space.

Trying to process this on Gannet also failed, for multiple reasons. Firstly, we seemed to be having stability problems with Gannet during this analysis. Frequently, Gannet was shut off, interrupting analysis. This may have been due to [bad batteries in the UPS that Gannet was connected to](https://robertslab.github.io/sams-notebook/2019/10/22/Lab-Maintenance-Cluster-UPS-Battery-Replacement.html). Secondly, despite the interruptions, I also encountered a couple of I/O errors (i.e. data transfer issues).

Both of these were particularly annoying because the analysis took multiple _days_ to  run!

However, these issues may have ended up being serendipitous, as it led me to read deeper into the MEGAN community forum and get a better understanding of how MEGAN works; particularly how it handles paired end sequencing data.

As such, I determined only one pair (and only one pair) of Meganized DAA files should be imported and processed at a time. Each pair took ~ 2 - 3 days to generate the expected RMA6 file. Each RMA6 file was generally very large (~40GB), however, the `MG3` RMA6 file is significantly smaller than the others (~24GB):

![screencap of RMA6 file sizes](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20191014_metagenomics_MEGAN6_filesize-01.png?raw=true)

---

#### RESULTS

Output folder:

- [20190925_metagenomics_DIAMOND_blastx/](https://gannet.fish.washington.edu/Atumefaciens/20190925_metagenomics_DIAMOND_blastx/)
