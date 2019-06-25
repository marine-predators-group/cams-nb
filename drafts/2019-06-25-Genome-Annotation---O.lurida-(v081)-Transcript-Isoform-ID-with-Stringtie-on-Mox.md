---
layout: post
title: Genome Annotation - O.lurida (v081) Transcript Isoform ID with Stringtie on Mox
date: '2019-06-25 08:04'
tags:
  - Ostrea lurida
  - annotation
  - Olurida_v081
  - stringtie
  - mox
  - Olympia oyster
categories:
  - Olympia Oyster Genome Sequencing
---


Command to pull trimmed files:

```shell
tar -ztvf trinity_out_dir.tar.gz \
| grep -E "*P.qtrim.gz" \
&& tar -zxvf trinity_out_dir.tar.gz \
-C /home/sam/Downloads/ \
--wildcards "*P.qtrim.gz"
```

---

#### RESULTS

Output folder:

- []()
