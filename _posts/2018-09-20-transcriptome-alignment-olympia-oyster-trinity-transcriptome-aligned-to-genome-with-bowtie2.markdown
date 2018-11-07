---
author: kubu4
comments: true
date: 2018-09-20 00:17:30+00:00
layout: post
link: http://onsnetwork.org/kubu4/2018/09/19/transcriptome-alignment-olympia-oyster-trinity-transcriptome-aligned-to-genome-with-bowtie2/
slug: transcriptome-alignment-olympia-oyster-trinity-transcriptome-aligned-to-genome-with-bowtie2
title: Transcriptome Alignment - Olympia oyster Trinity transcriptome aligned to genome
  with Bowtie2
wordpress_id: 3576
author:
- kubu4
categories:
- Miscellaneous
tags:
- bowtie2
- mox
- olympia oyster
- Ostrea lurida
- transcriptome
---

Progress on generating [bedgraphs from our Olympia oyster transcriptome](https://github.com/RobertsLab/resources/issues/356) continues.

[Transcriptome assembly with Trinity completed 20180919](http://onsnetwork.org/kubu4/2018/09/19/transcriptome-assembly-olympia-oyster-rnaseq-data-with-trinity/).

Next up, align transcriptome to Olympia oyster genome.

Alignment and creation of BAM files was done using Bowtie2 on our HPC Mox node.

SBATCH script file:





  * [20180919_oly_transcriptome_bowtie2.sh](http://owl.fish.washington.edu/Athaliana/20180919_oly_transcriptome_bowtie2/20180919_oly_transcriptome_bowtie2.sh)



Alignment was done using the following version of the Olympia oyster genome assembly:



  * [Olurida_v081.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Olurida_v081.fa)





* * *





#### RESULTS:



Output folder:





  * [20180919_oly_transcriptome_bowtie2/](http://owl.fish.washington.edu/Athaliana/20180919_oly_transcriptome_bowtie2/)



Sorted BAM file:



  * [20180919_Olurida_v081.sorted.bam](http://owl.fish.washington.edu/Athaliana/20180919_oly_transcriptome_bowtie2/20180919_Olurida_v081.sorted.bam)



Sorted & indexed BAM file (for IGV):



  * [20180919_Olurida_v081.sorted.bam.bai](http://owl.fish.washington.edu/Athaliana/20180919_oly_transcriptome_bowtie2/20180919_Olurida_v081.sorted.bam.bai)



Will get the sorted BAM file converted to a bedgraph for use in IGV.
