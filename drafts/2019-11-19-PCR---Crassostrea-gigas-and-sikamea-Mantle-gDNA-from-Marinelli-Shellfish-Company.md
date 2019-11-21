---
layout: post
title: PCR - Crassostrea gigas and sikamea Mantle gDNA from Marinelli Shellfish Company
date: '2019-11-19 15:37'
tags:
  - Crassostrea gigas
  - Pacific oyster
  - Crasssostrea sikamea
  - mantle
  - PCR
  - gel
  - Apex Red
categories:
  - Miscellaneous
---
After isolating DNA [earlier today](https://robertslab.github.io/sams-notebook/2019/11/19/DNA-Isolation-and-Quantification-Crassostrea-gigas-and-Crassostrea-sikamea-Mantle-Tissue-from-Marinelli-Shellfish-Company.html), I ran PCRs on all the samples.

Primers and cycling parameters were taken from this publication:

- [Haiyan Wang and Ximing Guo "Identification of Crassostrea ariakensis and Related Oysters by Multiplex Species-Specific PCR," Journal of Shellfish Research 27(3), 481-487, (1 May 2008).](https://www.researchgate.net/profile/Ximing_Guo/publication/259643859_Identification_of_Crassostrea_ariakensis_and_related_oysters_by_multiplex_species-specific_PCR/links/55c79eb708aeb9756746e35e/Identification-of-Crassostrea-ariakensis-and-related-oysters-by-multiplex-species-specific-PCR.pdf)

| SR ID | Primer Name | Sequence                   |
|-------|-------------|----------------------------|
| 1727  | COreverse   | CAGGGGGCCGTTCGCGGTCAACGCT  |
| 1726  | COCsi546r   | AAGTAACCTTAATAGATCAGGGAACC |
| 1725  | COCgi269r   | TCGAGGAAATTGCATGTCTGCTACAA |
| 1724  | COforward   | GGGACTACCCCCTGAATTTAAGCAT  |

This is a multiplex PCR, where the COforward/reverse primers should amplify any _Crassostrea spp._ DNA (i.e. a positive control - 697bp) and the other two primers will amplify either _C.gigas_ (Cgi269r - 269bp) or _C.sikamea_ (Csi546r - 546bp).


I ended up running this PCR two times, due to:

1. Ran the gel too far and ran most of the target products off the gel!

2. Many non-specific bands produced.

First PCR info:

| Component              | Single Rxn Vol. (uL) | Num. Rxns | Total Volumes (uL)        |
|------------------------|----------------------|-----------|---------------------------|
| DNA                    | 4                    | NA        | NA                        |
| 2x Apex Red Master Mix | 12.5                 | 18        | 225                       |
| P1 Mix                 | 1.5                  | 18        | 27                        |
| P2 Mix                 | 1.5                  | 18        | 27                        |
| H2O                    | 5.5                  | 18        | 99                        |
|                        | 25                   |           | Add 21uL to each PCR tube |


Cycling params:

95<sup>o</sup>C for 10mins

30 cycles of:

- 95<sup>o</sup>C 1min
- 51<sup>o</sup>C 1min
- 72<sup>o</sup>C 1min

72<sup>o</sup>C 10mins

Run on 0.8% agarose gel.

---

Since the first PCR didn't work, I made some changes:

1. Longer gel (1.5% agarose) to improve ability to resolve lower molecular weight bands.

2. Increase annealing temp and reduce extension time to try to increasae specificity.

3. Add primers individually instead of primer mixes.

| Component              | Single Rxn Vol. (uL) | Num. Rxns | Total Volumes (uL)        |
|------------------------|----------------------|-----------|---------------------------|
| DNA                    | 4                    | NA        | NA                        |
| 2x Apex Red Master Mix | 12.5                 | 18        | 225                       |
| COforward              | 0.15                 | 18        | 2.7                       |
| Coreverse              | 0.15                 | 18        | 2.7                       |
| COCgi269r              | 0.1                  | 18        | 1.8                       |
| COCsi546r              | 0.1                  | 18        | 1.8                       |
| H2O                    | 8                    | 18        | 144                       |
|                        | 25                   |           | Add 21uL to each PCR tube |

Cycling params:

95<sup>o</sup>C for 10mins

30 cycles of:

- 95<sup>o</sup>C 1min
- 55<sup>o</sup>C 1min
- 72<sup>o</sup>C 45secs

72<sup>o</sup>C 10mins

---

Used the GeneRuler DNA Ladder Mix (ThermoFisher) for all gels:

![GeneRuler DNA Ladder Mix](https://github.com/RobertsLab/resources/blob/master/protocols/Commercial_Protocols/ThermoFisher_OgeneRuler_DNA_Ladder_Mix_F100439.jpg?raw=true)

---

#### RESULTS


---

Gel #1

![Gel image from first PCR with too many bands; also ran target bands off gel](https://github.com/RobertsLab/sams-notebook/blob/master/images/20191119_gel_Cgigas_vs_Csikamea-01.jpg?raw=true)



---

Gel #2

![Gel image from 2nd PCR with anneal temp of 55C, showing no bands](https://github.com/RobertsLab/sams-notebook/blob/master/images/20191119_gel_Cgigas_vs_Csikamea-02.jpg?raw=true)
