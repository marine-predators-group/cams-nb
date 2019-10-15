---
layout: post
title: Synteny Analysis - Caligus rogercresseyi Genome Assembly from Cristian Gallardo with SEDEF on Mox
date: '2019-07-20 11:20'
tags:
  - Caligus rogercresseyi
  - synteny
  - SEDEF
  - emu
  - mox
categories:
  - Miscellaneous
---
We received a _Caligus rogercresseyi_ genome assembly from Cristian Gallardo (see this [GitHub Issue](https://github.com/RobertsLab/resources/issues/710)) to try to run Sibelia on our computers. I tried on Emu and on Mox and couldn't get the program to complete. On Emu, the primary issue was insufficient memory. I tried on Mox with the 128GB node and that also died due to insufficient memory. Both of those jobs ran for weeks before dying. I followed with two attempts on Mox with the 512GB node. These two attempts ran for 16 and 20 days, but timed out. Since the maximum amount of time we generally have for a job on Mox is 30 days (due to regular maintenance shutdowns), we can't use Sibelia for synteny analysis.

So, I'm trying another piece of software (using Mox) that Cristian had mentioned: [SEDEF](https://github.com/vpc-ccg/sedef).


---

#### RESULTS

Output folder:

- []()
