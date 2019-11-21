---
layout: post
title: PCR - Crassostrea gigas and sikamea Mantle gDNA from Marinelli Shellfish Company
date: '2019-11-21 11:05'
tags:
  - Crassostrea gigas
  - Crassostrea sikamea
  - Pacific oyster
  - Kumamoto
  - PCR
  - Apex
  - gel
categories:
  - Miscellaneous
---
After [yesterday's PCR debacles](https://robertslab.github.io/sams-notebook/2019/11/19/PCR-Crassostrea-gigas-and-sikamea-Mantle-gDNA-from-Marinelli-Shellfish-Company.html), I re-ran the PCRs with the original cylcing parameters, on a long 1.5% agarose (1x low TAE) gel.

Primers and cycling parameters were taken from this publication:

- [Haiyan Wang and Ximing Guo "Identification of Crassostrea ariakensis and Related Oysters by Multiplex Species-Specific PCR," Journal of Shellfish Research 27(3), 481-487, (1 May 2008).](https://www.researchgate.net/profile/Ximing_Guo/publication/259643859_Identification_of_Crassostrea_ariakensis_and_related_oysters_by_multiplex_species-specific_PCR/links/55c79eb708aeb9756746e35e/Identification-of-Crassostrea-ariakensis-and-related-oysters-by-multiplex-species-specific-PCR.pdf)

| SR ID | Primer Name | Sequence                   |
|-------|-------------|----------------------------|
| 1727  | COreverse   | CAGGGGGCCGTTCGCGGTCAACGCT  |
| 1726  | COCsi546r   | AAGTAACCTTAATAGATCAGGGAACC |
| 1725  | COCgi269r   | TCGAGGAAATTGCATGTCTGCTACAA |
| 1724  | COforward   | GGGACTACCCCCTGAATTTAAGCAT  |

This is a multiplex PCR, where the COforward/reverse primers should amplify any _Crassostrea spp._ DNA (i.e. a positive control - 697bp) and the other two primers will amplify either _C.gigas_ (Cgi269r - 269bp) or _C.sikamea_ (Csi546r - 546bp).

Master mix calcs:

| Component              | Single Rxn Vol. (uL) | Num. Rxns | Total Volumes (uL)        |
|------------------------|----------------------|-----------|---------------------------|
| DNA                    | 4                    | NA        | NA                        |
| 2x Apex Master Mix | 12.5                 | 18        | 225                       |
| COforward (100uM)              | 0.15                 | 18        | 2.7                       |
| Coreverse (100uM)           | 0.15                 | 18        | 2.7                       |
| COCgi269r (100uM)           | 0.1                  | 18        | 1.8                       |
| COCsi546r (100uM)            | 0.1                  | 18        | 1.8                       |
| H2O                    | 8                    | 18        | 144                       |
|                        | 25                   |           | Add 21uL to each PCR tube |


Cycling params:

95<sup>o</sup>C for 10mins

30 cycles of:

- 95<sup>o</sup>C 1min
- 51<sup>o</sup>C 1min
- 72<sup>o</sup>C 1min

72<sup>o</sup>C 10mins


---

#### RESULTS

Gel:

![Gel of four PCRs from each group of oysters](https://github.com/RobertsLab/sams-notebook/blob/master/images/20191121_gel_C.gigas_C.sikamea-01.jpg?raw=true)
