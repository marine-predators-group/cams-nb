---
layout: post
title: Data Wrangling - CpG OE Calculations on C.virginica Genes
date: '2019-02-26 15:11'
tags:
  - Crassostrea virginica
  - Eastern oyster
  - swoose
  - jupyter notebook
  - seqkit
categories:
  - Miscellaneous
---
Steven tasked me with processing ~90 FastA files containing gene sequences from _C.virginica_ in [this GitHub Issue](https://github.com/RobertsLab/resources/issues/593). He needed to determine the Observed/Expected (O/E) ratio of CpGs in each FastA. He provided this [example code](http://htmlpreview.github.io/?https://github.com/hputnam/EastOyEpi/blob/master/02-Cpg-test.html) and this [link to all the files](http://gannet.fish.washington.edu/seashell/bu-serine-wd/19-01-08/). Additionally, today, he tasked [Kaitlyn with merging all of the output CpG O/E values for each sample](https://github.com/RobertsLab/resources/issues/596) in to a single file, but I decided to tackle it anyway.

The CpG O/E determination was done in a Jupyter Notebook:

- [20190225_swoose_CpG_OE.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190225_swoose_CpG_OE.ipynb) (GitHub)

Interestingly, the processing (which relied on ```awk```) required the use of ```gawk```, due to the high number of output fields. The default implementation of ```awk``` on the version of Ubuntu I was using was _not_ ```gawk```.

The creation of a single file with all of the CpG O/E info is detailed in this ```bash``` script:

- [20190226_join_ID_CpGs.sh](http://gannet.fish.washington.edu/Atumefaciens/20190225_cpg_oe/20190226_join_ID_CpGs.sh)

<pre><code>
#!/bin/bash

## Script to append sample-specific headers to each ID_CpG
## file and join all ID_CpG files.

## Run file from within this directory.

# Temp file placeholder
tmp=$(mktemp)

# Create array of subdirectories.
array=(*/)

# Create column headers for ID_CpG files using sample name from directory name.
for file in ${array[@]}
do
  gene=$(echo ${file} | awk -F\[._] '{print $6"_"$7}')
  sed "1iID\t${gene}" ${file}ID_CpG > ${file}ID_CpG_labelled
done

# Create initial file for joining
cp ${array[0]}ID_CpG_labelled ID_CpG_labelled_all

# Loop through array and performs joins.
for file in ${array[@]:1}
do
  join \
  --nocheck-order \
  ID_CpG_labelled_all ${file}ID_CpG_labelled \
  | column -t \
  > ${tmp} \
  && mv ${tmp} ID_CpG_labelled_all
done
</code></pre>
