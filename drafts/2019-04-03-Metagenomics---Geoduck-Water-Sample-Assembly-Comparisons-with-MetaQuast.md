---
layout: post
title: Metagenomics - Geoduck Water Sample Assembly Comparisons with MetaQuast
date: '2019-04-03 20:39'
tags:
  - metagenomics
  - Panopea generosa
  - metaquast
  - geoduck
categories:
  - Miscellaneous
---
As part of addressing this [GitHub Issue on assessing taxonomic diversity in our metagenomics samples](https://github.com/RobertsLab/resources/issues/547), I decided to compare the individual sample assemblies [I made on 20190327 using Megahit](https://robertslab.github.io/sams-notebook/2019/03/27/Metagenome-Assemblies-P.generosa-Water-Samples-Trimmed-HiSeqX-Data-Using-Megahit-on-Mox.html) and the assemblies that Emma made. Emma utilized [NGless](https://github.com/ngless-toolkit/ngless) on her cluster in Genome Sciences with the following scripts:

- [ngless.job](http://eagle.fish.washington.edu/oyster/metagenomics_2019/ngless.job)

<pre><code>
#!/bin/bash

#$ -cwd
#$ -S /bin/bash
#$ -o ./output
#$ -e ./output
#$ -l mfree=3G
#$ -pe serial 16
#$ -R y

# Send email when job starts, ends or runs into an error
#$ -m beas
#$ -M emmats@uw.edu

#cause a failing process to trigger a job failure to make errors easier to catch
set -eo pipefail

#Initialize and load modules
. /etc/profile.d/modules.sh
module purge
module load modules{,-{init,gs/prod}} ngless/0.10.0

#Script
ngless \
   /net/nunn/vol1/emmats/sequencing/geo_metaG/ngl.singleLibs \
   --trace \
   --keep-temporary-files \
   -j $NSLOTS \
   -t /data/scratch/ssd
</code></pre>

---

- [ngl.singleLibs](http://eagle.fish.washington.edu/oyster/metagenomics_2019/ngl.singleLibs)

<pre><code>
ngless "0.10"
import "parallel" version "0.6"

samples = readlines('MG7S2')
sample = lock1(samples)
input = fastq(sample)

output = preprocess(input, keep_singles=False) using |read|:
   read = substrim(read, min_quality=25)
   if len(read) < 45:
     discard

contigs = assemble(input)
write(contigs, ofile='contigsM7S2.fa')

orfs = orf_find(contigs, is_metagenome=True)
write(contigs, ofile='orfM7S2.fna')
</code></pre>

I `rsync`'d all the assembly files to my computer (swoose) and ran [MetaQuast](http://quast.sourceforge.net/metaquast) locally. I did _not_ provide MetaQuast with individual reads, nor reference, as I just wanted a quick and dirty assessment of each of the assemblies. For a more in-depth comparison, I'm currently running [Anvi'o](http://merenlab.org/software/anvio/) on Mox.

---

#### RESULTS
