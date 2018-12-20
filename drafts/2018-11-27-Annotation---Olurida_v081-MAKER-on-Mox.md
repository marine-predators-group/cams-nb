---
layout: post
title: Annotation - Olurida_v081 MAKER on Mox
date: '2018-11-27 14:40'
tags:
  - Ostrea lurida
  - Olympia oyster
  - mox
  - MAKER
  - genome annotation
  - Olurida_v081
categories:
  - Olympia Oyster Genome Sequencing
---
Remarkably, I managed to burn through our [Xsede computing resources](https://robertslab.github.io/sams-notebook/2018/08/07/genome-annotation-olympia-oyster-genome-using-wq-maker-instance-on-jetstream.html) and don't have terribly much to show for it. Ooof! This is a major bummer, as it "only" takes ~8hrs for a WQ-MAKER job to run there, as opposed to [_months_ the last time I tried running it on Mox](https://robertslab.github.io/sams-notebook/2018/07/11/mox-olympia-oyster-genome-annotation-progress-using-maker-2-31-10.html). Although we have used up our Xsede allocation, all is not lost! The experience of setting up/running WQ-MAKER has enlightened me on how it all works and how to run it on Mox so it will (hopefully) take far, far less time than the last Mox attempt. With that said, here we go...

Firstly, I re-installed MAKER (v2.31.10) and configured for OpenMPI support. This is computing jargon that basically allows MAKER to work on a computer cluster efficiently. Now that we have two Mox nodes, I think this will help accelerate the process.

With that out of the way, here's a _very_ brief overview of the entire MAKER annotation process:

1. Create custom repeat library for your organism ([did this with RepeatModeler on 20181022](https://robertslab.github.io/sams-notebook/2018/10/22/Repeat-Library-Construction-O.lurida-RepeatModeler-v1.0.11.html))

2. Provide RNAseq data ([Trinity assembly from 20180919](https://robertslab.github.io/sams-notebook/2018/09/19/transcriptome-assembly-olympia-oyster-rnaseq-data-with-trinity.html))

3. Provide species-specific and/or related proteomic data (used publicly available proteomes from NCBI for _C.gigas_ ([GCA_000297895.1_oyster_v9](ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/297/895/GCA_000297895.1_oyster_v9/)) and _C.virginica_ ([GCF_002022765.2_C_virginica-3.0](ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/002/022/765/GCF_002022765.2_C_virginica-3.0/))

4. Run MAKER to produce initial gene models.

5. Merge all the hundred thousands (seriously) of individual GFFs and FastAs in to a singular file of each file type.

6. Generate _ab initio_ gene prediction using [SNAP](https://github.com/KorfLab/SNAP). This is integrated in to MAKER.

7. Run MAKER again, using the SNAP gene models.

8. Run SNAP a second time.

9. Run MAKER a _third_ time using the second set of SNAP gene models.


All files were ```rsync```'d to my folder on Gannet.

---

#### RESULTS

This actually completed, and in a reasonable (relatively) amount of time (2 weeks)!

![](https://gannet.fish.washington.edu/Atumefaciens/images/20181210_mox_maker_complete.png)

Output directory:

- [20181127_oly_maker_genome_annotation/](https://gannet.fish.washington.edu/Atumefaciens/20181127_oly_maker_genome_annotation/)
