---
layout: post
title: Genome Annotation - Pgenerosa_v074 a4 Using GenSAS
date: '2019-09-28 10:01'
tags:
  - GenSAS
  - geoduck
  - Panopea generosa
  - v074
  - Pgenerosa_v074
  - v074.a4
  - Panopea-generosa-vv0.74.a4
  - annotation
categories:
  - Geoduck Genome Sequencing
---



---

#### RESULTS

Output folder:

- []()

Merged GFF (SwissProt IDs in Column 9 - from BLASTp and DIAMOND):

- ()[]


BUSCO assessment (metazoa_odb9):

- 71.5% complete BUSCOs present in predicted genes

---

Feature counts:

```shell
awk 'NR>3 {print $3}' Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3 | sort | uniq -c

 236960 CDS
 236960 exon
  34947 gene
  38326 mRNA
1527155 repeat_region
      7 rRNA
  15514 tRNA

```

Individual feature GFFs were made with the following shell commands:

```shell
features_array=(CDS exon gene mRNA repeat_region rRNA tRNA)

input="Panopea-generosa-vv0.74.a4-merged-2019-10-07-4-46-46.gff3"

for feature in ${features_array[@]}
do
output="Panopea-generosa-vv0.74.a4.${feature}.gff3"
head -n 3 ${input} \
>> ${output}
awk -v feature="$feature" '$3 == feature {print}' ${input} \
>> ${output}
done
```
