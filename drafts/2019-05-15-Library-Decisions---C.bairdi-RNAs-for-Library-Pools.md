---
layout: post
title: Library Decisions - C.bairdi RNAs for Library Pools
date: '2019-05-14 14:38'
tags:
  - tanner crab
  - RNA
  - Chionoecetes bairdi
categories:
  - Miscellaneous
---
I isolated a bunch of tanner crab RNA on [20190430](https://robertslab.github.io/sams-notebook/2019/04/30/RNA-Isolation-and-Quantification-C.bairdi-Hemolymph-Pellet-in-RNAlater.html) and Steven asked me to try to figure out some options for RNAseq libray pools.

Using Grace's table join of my Qubit data ([hemo_qub-for-libs.csv](https://raw.githubusercontent.com/RobertsLab/project-crab/8f95500019075d917e9cee013af325cf3a7d0bda/analyses/hemo_qub-for-libs.csv)), I created a pivot table to quickly get an idea of how things looked (note: I added a column with total RNA yield for each sample - 10uL * concentration):

![C.bairdi pivot table screen cap](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190514_cbai_library_table.png?raw=true)
