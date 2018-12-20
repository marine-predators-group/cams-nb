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


All files were ```rsync```'d to my folder on Gannet.

---

#### RESULTS

This actually completed, and in a relatively reasonable amount of time (2 weeks)!

![](https://gannet.fish.washington.edu/Atumefaciens/images/20181210_mox_maker_complete.png)

Output directory:

- [20181127_oly_maker_genome_annotation/](https://gannet.fish.washington.edu/Atumefaciens/20181127_oly_maker_genome_annotation/)
