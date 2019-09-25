---
layout: post
title: Metagenomics Annotation - P.generosa Water Samples Using DIAMOND BLASTx on Mox
date: '2019-09-25 14:34'
tags:
  - Panopea generosa
  - geoduck
  - metagenomics
  - DIAMOND
  - mox
  - MEGAN6
categories:
  - Miscellaneous
---
We recently had a meeting with Emma and Brook about the progress of this metagenomics project and Brook suggested trying out [MEGAN6](https://ab.inf.uni-tuebingen.de/software/megan6) as user-friendly way to get these samples annotated.

Although [MEGAN6](https://ab.inf.uni-tuebingen.de/software/megan6) will accept BLAST output as input, it has to be formatted in a certain way. Although I've previously BLASTed these data, the outputs of those were not formatted in a way that is readily able to be imported into MEGAN6, so instead I opted to re-BLAST these using [DIAMOND](https://github.com/bbuchfink/diamond) (which is produced by the same group that created MEGAN6), as it is significantly faster than BLASTx and has output formats that are geared towards import to MEGAN6.

I downloaded the NCBI nr BLASTdb in FastA format:

`ftp://ftp.ncbi.nih.gov/blast/db/FASTA/nr.gz`

I prepared the DIAMOND BLASTdb (`nr.dmnd`) with the following command:

```shell
/gscratch/srlab/programs/diamond-0.9.26/diamond makedb \
--in nr.faa \
-d nr \
--taxonmap prot.accession2taxid \
--taxonnodes nodes.dmp
```
The taxonmap and taxon node files were downloaded from the following NCBI locations:

- `ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/accession2taxid/prot.accession2taxid.gz`

- `ftp://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip`

---

#### RESULTS

Output folder:

- [20190925_metagenomics_DIAMOND_blastx/](https://gannet.fish.washington.edu/Atumefaciens/20190925_metagenomics_DIAMOND_blastx/)
