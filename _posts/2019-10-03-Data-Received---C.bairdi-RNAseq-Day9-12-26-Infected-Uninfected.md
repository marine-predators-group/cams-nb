---
layout: post
title: Data Received - C.bairdi RNAseq Day9-12-26 Infected-Uninfected
date: '2019-10-03 13:30'
tags:
  - tanner crab
  - RNAseq
  - Chionoecetes bairdi
categories:
  - Miscellaneous
---
#### UPDATE (20191024): This post details receipt of incomplete data. Additional sequencing was performed and that additional data was received 20191024. This [notebook entry on 20191024](https://robertslab.github.io/sams-notebook/2019/10/24/Data-Received-C.bairdi-RNAseq-Day9-12-26-Infected-Uninfected.html) contains details on FastQ concatenation of the data below and the data received on 20191024.

Finally received the RNAseq data back from NWGC that we submitted on [20190521](https://robertslab.github.io/sams-notebook/2019/05/21/Sample-Submission-Tanner-Crab-Infected-vs-Uninfected-RNAseq.html)!

Here's a table with the library names and the FastQ naming schemes.


| NWGC Sample ID | Investigator Sample ID |
|----------------|------------------------|
| 329772         | D9_infected            |
| 329773         | D9_uninfected          |
| 329774         | D12_infected           |
| 329775         | D12_uninfected         |
| 329776         | D26_infected           |
| 329777         | D26_uninfected         |

---

Here's the list of FastQ files:

- 329774_S1_L001_R1_001.fastq.gz

- 329774_S1_L001_R2_001.fastq.gz

- 329774_S1_L002_R1_001.fastq.gz

- 329774_S1_L002_R2_001.fastq.gz

- 329775_S2_L001_R1_001.fastq.gz

- 329775_S2_L001_R2_001.fastq.gz

- 329775_S2_L002_R1_001.fastq.gz

- 329775_S2_L002_R2_001.fastq.gz

- 329776_S3_L001_R1_001.fastq.gz

- 329776_S3_L001_R2_001.fastq.gz

- 329776_S3_L002_R1_001.fastq.gz

- 329776_S3_L002_R2_001.fastq.gz

- 329777_S4_L001_R1_001.fastq.gz

- 329777_S4_L001_R2_001.fastq.gz

- 329777_S4_L002_R1_001.fastq.gz

- 329777_S4_L002_R2_001.fastq.gz


All files have been added to nightingales/C_bairdi:

- [nightingales/C_bairdi](https://owl.fish.washington.edu/nightingales/C_bairdi/)

Will update readme and [Nightingales Google sheet](http://b.link/nightingales)

---

I just realized that the list of FastQ files does not match the list of NWGC Sample IDs (329772 and 329773 do not have corresponding FastQ files). I've emailed the facility and this was their response:


>Machiko Threlkeld
>6:14 PM (3 hours ago)
>to Sam, Peter, Stephanie
>
>Hi Sam,
>
>I am sorry. I should have been more clear. 2 samples of yours failed sequencing steps and we didn't have any more samples left to repeat the process. The QC results show that those two had less than 10ul to start with.
>
>Here is the summary of your project:
>
>\# total samples submitted = 6
>
>\# samples approved for sequencing = 6
>
>\# samples passed sequencing QC and released = 4
>
>I hope you understand.
>
>Thank you,
>Machiko

So, this is the first I'm hearing of any concern with these two particular samples. Especially since they passed the initial QC on [20190610](https://robertslab.github.io/sams-notebook/2019/05/21/Sample-Submission-Tanner-Crab-Infected-vs-Uninfected-RNAseq.html)!

Here's my response; I'll update this post when they respond:


>Sam White <samwhite@uw.edu>
>8:58 PM (32 minutes ago)
>to Machiko, Peter, Stephanie
>
>Hi Machiko,
>
>I definitely do not understand.
>
>The initial QC report you sent to me indicated that these two samples PASSED QC (there was only one sample that failed QC - that sample ended up getting sequenced without issue).
>
>Additionally, I'm not sure why the volume of the samples is relevant. The QC report clearly indicated that both samples had less than 10uL, yet they PASSED QC. Also, if there was a concern with low sample volume, why not add the additional water to each sample? If the volumes had been adjusted to 10uL, the resulting concentrations for both of those samples would have been ~100ng/uL; on par with the other samples. So, I am having difficulty believing that the sample volume was an issue of any sort.
>
>Regardless, the QC report indicated those two samples passed QC. So now what?
>
>Thanks for any insight you can provide.
>
>
>Sam
