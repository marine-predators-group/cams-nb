---
layout: post
title: Sequence Subsetting - Pgenerosa_v70 Genome Assembly with faidx
date: '2019-02-11 20:41'
tags:
  - faix
  - Panopea generosa
  - geoduck
  - Pgenerosa_v70
categories:
  - Miscellaneous
---

```
faidx --size-range 10000,1000000000 Pgenerosa_v070.fa > Pgenerosa_v070_10k_plus.fasta
```

```
faidx Pgenerosa_v070_10k_plus.fasta
```

```
faidx --size-range 30000,1000000000 Pgenerosa_v070.fa > Pgenerosa_v070_30k_plus.fasta

```

```
faidx Pgenerosa_v070_30k_plus.fasta
```


35b6b653b543ebb7f3631e68523ab595  Pgenerosa_v070_10k_plus.fasta
ce81a0fc127e6cc0cbf216eb85b87749  Pgenerosa_v070_30k_plus.fasta
