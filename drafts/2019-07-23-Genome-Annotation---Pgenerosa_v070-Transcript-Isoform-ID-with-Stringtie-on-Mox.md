---
layout: post
title: Genome Annotation - Pgenerosa_v070 Transcript Isoform ID with Stringtie on Mox
date: '2019-07-23 14:56'
tags:
  - mox
  - stringtie
  - gtf
  - Pgenerosa_v070
  - v070
  - Panopea generosa
  - geoduck
categories:
  - Geoduck Genome Sequencing
---
After annotating Pgenerosa_v074 and [comparing feature counts](https://robertslab.github.io/sams-notebook/2019/07/22/Genome-Annotation-Pgenerosa_v070-and-v074-Top-18-Scaffolds-Feature-Count-Comparisons.html), there was a drastic difference between the two genome versions. Additionally, both of those genomes ended up with no CDS/exon/gene/mRNA features identified in the largest scaffold. So, to explore this further by seeing where (if??) sequencing reads map to the scaffold, and to obtain transcript isoforms for the genome, I ran Stringtie. A [Hisat2 index was prepared earlier](https://robertslab.github.io/sams-notebook/2019/07/23/Genome-Annotation-Pgenerosa_v070-Hisat2-Transcript-Isoform-Index.html).

Here's the quick rundown of how transcript isoform annotation with Stringtie runs:

1. Use Hisat2 reference index with identified splice sites and exons (this was done earlier).

2. Use Hisat2 to create alignments from each pair of trimmed FastQ files. _Need to use the `--downstream-transcriptome-assembly` option!!!_

3. Use Stringtie to create a GTF for each alignment.

4. Use Stringtie to create a singular, merged GTF from all of the individual GTFs.

The trimmed FastQ files used were extracted from the following Trinity assemblies (links to notebooks):

- [ctenidia (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Ctenidia-with-HiSeq-and-NovaSeq-Data-on-Mox.html)

- [gonad (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Gonad-HiSeq-and-NovaSeq-Data-on-Mox.html)

- [heart (20190215)](https://robertslab.github.io/sams-notebook/2019/02/15/Transcriptome-Assembly-Geoduck-Tissue-Specific-Assembly-Heart.html)

- [EPI99 (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Larvae-Day5-EPI99-with-HiSeq-and-NovaSeq-Data-on-Mox.html)

- [EPI115 (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI115-with-HiSeq-Data-on-Mox.html)

- [EPI116 (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI116-with-HiSeq-Data-on-Mox.html)

- [EPI123 (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI123-with-HiSeq-Data-on-Mox.html)

- [EPI124 (20190409)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI124-with-HiSeq-and-NovaSeq-Data-on-Mox.html)

See the [fastq.list.txt](https://gannet.fish.washington.edu/Atumefaciens/20190723_stringtie_pgen_v070/fastq.list.txt) for the list of FastQ files used as input. Also, see the [Nightingales Google Sheet](http://b.link/nightingales) for more details on sequencing files.
NOTE: The "P" in the `*.P.qtrim.gz` represents trimmed reads that are properly paired, as determined by Trimmomatic/Trinity.

---

#### RESULTS

Output folder:

- []()
