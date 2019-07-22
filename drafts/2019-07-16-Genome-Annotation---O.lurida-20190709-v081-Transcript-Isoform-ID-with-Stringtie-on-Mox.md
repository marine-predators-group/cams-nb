---
layout: post
title: Genome Annotation - O.lurida 20190709-v081 Transcript Isoform ID with Stringtie on Mox
date: '2019-07-16 15:07'
tags:
  - Ostrea lurida
  - Olympia oyster
  - mox
  - stringtie
  - gtf
  - 20190709-v081
  - annotation
  - isoforms
categories:
  - Olympia Oyster Genome Sequencing
---
[Earlier today, I generated the necessary Hista2 index, which incorporated splice sites and exons](https://robertslab.github.io/sams-notebook/2019/07/16/Genome-Annotation-O.lurida-20190709-v081-Hisat2-Transcript-Isoform-Index.html), for use with Stringtie in order to identify transcript isoforms in our [20190709-Olurida_v081 annotation](https://robertslab.github.io/sams-notebook/2019/07/09/Genome-Annotation-Olurida_v081-with-MAKER-and-Tissue-specific-Transcriptomes-on-Mox.html). This annotation utilized tissue-specific transcriptome assemblies provided by Katherine Silliman.

I used all the trimmed FastQ files from the [20180827 Trinity transcriptome assembly](https://robertslab.github.io/sams-notebook/2018/09/19/transcriptome-assembly-olympia-oyster-rnaseq-data-with-trinity.html), as this utilized all of our existing RNAseq data.

- [20180827_trinity_oly_RNAseq/trinity_out_dir.tar.gz](https://owl.fish.washington.edu/Athaliana/20180827_trinity_oly_RNAseq/trinity_out_dir.tar.gz)

Command to pull trimmed files (Trimmomatic) out of the Trinity output folder that is a gzipped tarball:

```shell
tar -ztvf trinity_out_dir.tar.gz \
| grep -E "*P.qtrim.gz" \
&& tar -zxvf trinity_out_dir.tar.gz \
-C /home/sam/Downloads/ \
--wildcards "*P.qtrim.gz"
```

This was run locally on my computer (swoose) and then `rsync`'d to Mox.

NOTE: The "P" in the `*.P.qtrim.gz` represents trimmed reads that are properly paired, as determined by Trimmomatic/Trinity. See the [fastq.list.txt](https://gannet.fish.washington.edu/Atumefaciens/20190625_stringtie_oly_v081/fastq.list.txt) for the list of FastQ files used as input. For more info on input FastQ files, refer to [the Nightingales Google Sheet](http://b.link/nightingales).


Here's the quick rundown of how transcript isoform annotation with Stringtie runs:

1. Use Hisat2 reference index with identified splice sites and exons (this was done yesterday).

2. Use Hisat2 to create alignments from each pair of trimmed FastQ files. _Need to use the `--downstream-transcriptome-assembly` option!!!_

3. Use Stringtie to create a GTF for each alignment.

4. Use Stringtie to create a singular, merged GTF from all of the individual GTFs.


SBATCH script (GitHub):


---

#### RESULTS

Output folder:

- []()
