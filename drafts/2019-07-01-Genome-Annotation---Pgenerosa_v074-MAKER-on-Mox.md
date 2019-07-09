---
layout: post
title: Genome Annotation - Pgenerosa_v074 MAKER on Mox
date: '2019-07-01 10:29'
tags:
  - Panopea generosa
  - geoduck
  - MAKER
  - mox
  - annotation
  - genome
  - v074
categories:
  - Geoduck Genome Sequencing
---
[I previously created a subset of the Pgenerosa_v070 genome assembly](https://robertslab.github.io/sams-notebook/2019/06/25/Data-Wrangling-FastA-Subsetting-of-Pgenerosa_v070.fa-Using-samtools-faidx.html) that contains just the largest 18 scaffolds (these scaffolds were produced by Phase Genomics, utilizing some Hi-C sequencing). The new subsetted genome is labeled as [Pgenerosa_v074.fa](http://owl.fish.washington.edu/halfshell/genomic-databank/Pgenerosa_v074.fa) (914MB).

As part of that, [Steven wanted this version annotated using MAKER](https://github.com/RobertsLab/resources/issues/707).

Here are a list of the input files used for the various components of the MAKER annotation:


#### Transcriptome FastA files (links to notebook entries):
- [ctenidia](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Ctenidia-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [gonad](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Gonad-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [heart](https://robertslab.github.io/sams-notebook/2019/02/15/Transcriptome-Assembly-Geoduck-Tissue-Specific-Assembly-Heart.html)
- [EPI99 (larvae)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Larvae-Day5-EPI99-with-HiSeq-and-NovaSeq-Data-on-Mox.html)
- [EPI115 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI115-with-HiSeq-Data-on-Mox.html)
- [EPI116 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Super-Low-OA-EPI116-with-HiSeq-Data-on-Mox.html)
- [EPI123 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI123-with-HiSeq-Data-on-Mox.html)
- [EPI124 (juvenile)](https://robertslab.github.io/sams-notebook/2019/04/09/Transcriptome-Assembly-Geoduck-Tissue-specific-Assembly-Juvenile-Ambient-OA-EPI124-with-HiSeq-and-NovaSeq-Data-on-Mox.html)

#### NCBI Protein FastA files
- NCBI _Crassostrea gigas_ proteome (downloaded 20181119): `GCA_000297895.1_oyster_v9_protein.faa`

- NCBI _Crassostrea virginica_ proteome (downloaded 20181119): `GCF_002022765.2_C_virginica-3.0_protein.faa`

- SwissProt BLASTp database(downloaded 20190109): uniprot_sprot.fasta

#### TransDecoder protein FastA files (links to notebook entries)
- [singular proteome](https://robertslab.github.io/sams-notebook/2018/11/21/Annotation-Geoduck-Transcritpome-with-TransDecoder.html)
- [ctenidia](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Ctenidia-with-Transdecoder-on-Mox.html)
- [EPI99 (larvae)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Larvae-Day5-EPI99-with-Transdecoder-on-Mox.html)
- [EPI115 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Super-Low-OA-EPI115-with-Transdecoder-on-Mox.html)
- [EPI116 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Super-Low-OA-EPI116-with-Transdecoder-on-Mox.html)
- [EPI123 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Ambient-OA-EPI123-with-Transdecoder-on-Mox.html)
- [EPI124 (juvenile)](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Juvenile-Ambient-OA-EPI124-with-Transdecoder-on-Mox.html)
- [gonad](https://robertslab.github.io/sams-notebook/2019/06/27/Transcriptome-Annotation-Geoduck-Gonad-with-Transdecoder-on-Mox.html)
- [heart](https://robertslab.github.io/sams-notebook/2019/03/18/Transcriptome-Annotation-Geoduck-Heart-with-Transdecoder-on-Mox.html)

#### Repeats Files
- [RepeatModeler library](https://robertslab.github.io/sams-notebook/2019/06/26/RepeatModeler-Pgenerosa_v074-for-MAKER-Annotation-on-Emu.html)

- [RepeatMasker GFF](https://robertslab.github.io/sams-notebook/2019/06/26/RepeatMasker-Pgenerosa_v074-for-Transposable-Element-ID-on-Roadrunner.html)


SBATCH script (GitHub):

- [20190701_pgen_maker_v074_annotation.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190701_pgen_maker_v074_annotation.sh)

```shell

```

---

#### RESULTS

Output folder:

- []()
