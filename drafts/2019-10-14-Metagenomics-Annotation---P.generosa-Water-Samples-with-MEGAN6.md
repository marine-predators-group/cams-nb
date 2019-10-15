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
After running [DIAMOND BLASTx and MEGANIZER on these samples on 20190925](https://robertslab.github.io/sams-notebook/2019/09/25/Metagenomics-Annotation-P.generosa-Water-Samples-Using-DIAMOND-BLASTx-on-Mox.html) to assing taxonomy info, I began the analyses/visualization of this data with (MEGAN6)[https://uni-tuebingen.de/fakultaeten/mathematisch-naturwissenschaftliche-fakultaet/fachbereiche/informatik/lehrstuehle/algorithms-in-bioinformatics/software/megan6/].


After running for an entire day, my hard drive ran out of space! Turns out, each of the MEGAN6 files generated are going to be HUGE:

![Screencap showing 178GB MEGAN6 file size for a single sample](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20191014_metagenomics_MEGAN6_filesize.png?raw=true)

If each sample is going to generate a 178GB (or larger?) file, I need to run this analysis directly on Gannet, as my computer's HDD won't have enough space...

---

#### RESULTS

Output folder:

- []()
