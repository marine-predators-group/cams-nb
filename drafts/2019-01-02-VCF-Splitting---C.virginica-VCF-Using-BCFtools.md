---
layout: post
title: VCF Splitting - C.virginica VCF Using BCFtools
date: '2019-01-02 07:39'
tags:
  - bcftools
  - Crassostrea virginica
  - Eastern oyster
  - tabix
categories:
  - Miscellaneous
---
[Steven asked that I split up a _Crassostrea virginica_ VCF file](https://github.com/RobertsLab/resources/issues/528):

- [Combined.SNP.TRSdp5g95FnDNAmaf05.vcf.gz (31GB)](http://gannet.fish.washington.edu/seashell/eog_v2/VCF_files/Combined.SNP.TRSdp5g95FnDNAmaf05.vcf.gz)


Overview of process:

1. Downloaded file.

2. Gunzipped file.

3. Sorted file with ```awk``` command found at

Jupyter Notebook (GitHub):

- [20190103_swoose_C.virginica_vcf_splitting.ipynb](https://github.com/RobertsLab/code/blob/master/notebooks/sam/20190103_swoose_C.virginica_vcf_splitting.ipynb)
