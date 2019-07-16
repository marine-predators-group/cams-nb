---
layout: post
title: Genome Annotation - Olurida_v081 with MAKER and Tissue-specific Transcriptomes on Mox
date: '2019-07-09 07:56'
tags:
  - Olurida v081
  - v081
  - Ostrea lurida
  - Olympia oyster
  - mox
  - MAKER
  - annotation
categories:
  - Olympia Oyster Genome Sequencing
---
I [previously annotated our Olurida_v081 genome with MAKER](https://robertslab.github.io/sams-notebook/2018/11/27/Annotation-Olurida_v081-MAKER-on-Mox.html) using our "canonical" transcriptome, [Olurida_transcriptome_v3.fasta](http://eagle.fish.washington.edu/cnidarian/Olurida_transcriptome_v3.fasta) as the EST evidence utilized by MAKER. A [discussion on one of our Slack channels related to the lack of isoform annotation](https://genefish.slack.com/archives/GHB1LCNRW/p1560978863004100) (I think it's a private channel, sorry) prompted Katherine Silliman to suggest re-running the annotation using tissue-specific transcriptome assemblies that she has generated as EST evidence, instead of a singular transcriptome. Since I already had previous versions of the MAKER script that I've used for annotations, re-running was rather straightforward. While this was running, I used [Stringtie on 20190625to produce a GTF that maps out potential isoforms](https://robertslab.github.io/sams-notebook/2019/06/25/Genome-Annotation-O.lurida-(v081)-Transcript-Isoform-ID-with-Stringtie-on-Mox.html), as I don't believe MAKER will actually predict isoforms, since it didn't do so the first time, nor has it with other annotations we've run on geoduck assemblies.






---

#### RESULTS

This took ~5.75 days to run:

![Screencap of Olurida_v081 annotation runtime](https://github.com/RobertsLab/sams-notebook/blob/master/images/screencaps/20190709_maker_olur81_runtime.png?raw=true)

Output folder:

- []()
