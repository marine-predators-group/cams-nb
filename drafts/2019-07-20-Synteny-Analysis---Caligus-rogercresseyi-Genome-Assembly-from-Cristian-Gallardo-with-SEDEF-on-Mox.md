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

Before I can SEDEF, all repeat regions need to be soft-masked (i.e. identified and replaced with lowercase letters). To do so, I ran RepeatMasker (v0.4.0) on Emu.

 Bash script (GitHub):

 - [20191015_crog_repeatmasker.sh](https://github.com/RobertsLab/sams-notebook/blob/master/bash_scripts/20191015_crog_repeatmasker.sh)

```shell
#!/usr/bin/bash

# Script to subset top 21 scaffolds of C_rogercresseyi genome assembly,
# and create a soft-masked (lowercase repeats) FastA for use with SEDEF.
# Assembly provided by Cristian Gallardo.
# Run on Emu.

# Exit if any command fails
set -e

# Set CPUs
cpus=16

# Input/output files
assembly_fasta="Caligus_rogercresseyi_Genome.fa"
assembly_index="Caligus_rogercresseyi_Genome.fa.fai"
assembly_subset="C_rogercresseyi_top_21_scaffold.fa"
system_specs="system_info.txt"
subset_list="top_21_scaffold_list.txt"

# Program paths
samtools="/home/shared/samtools-1.8/samtools"
repeatmasker="/home/shared/RepeatMasker-4.0.7/RepeatMasker"


# Record system info
{
echo "TODAY'S DATE:"
date
echo "------------"
echo ""
lsb_release -a
echo ""
echo "------------"
echo "HOSTNAME: " hostname
echo ""
echo "------------"
echo "Computer Specs:"
echo ""
lscpu
echo ""
echo "------------"
echo ""
echo "Memory Specs"
echo ""
free -mh
} >> "${system_specs}"


# Index assembly FastA file
"${samtools}" faidx \
"${assembly_fasta}"

# Extract list of top 21 longest scaffolds
sort \
--numeric-sort \
--reverse \
--field-separator $'\t' \
--key 2,2 \
"${assembly_index}" \
| head -n 21 \
| awk -F'\t' '{print $1}' \
> "${subset_list}"

# Create FastA of longest 21 scaffolds
xargs \
"${samtools}" faidx \
"${assembly_fasta}" \
< "${subset_list}" \
> "${assembly_subset}"

# Run RepeatMasker on longest 21 scaffolds
# -xsmall option generates lowercase, soft-masked repeats (instead of replacing with Xs)
time \
${repeatmasker} \
${assembly_subset} \
-species "all" \
-pa ${cpus} \
-excln \
-xsmall \
1> stdout.out \
2> stderr.err

# Email me when finished
sed '/^Subject:/ s/ / repeatmasker_C_rog_all JOB COMPLETE/' ~/.default-subject.mail | msmtp "$EMAIL"
```

---

#### RESULTS

Output folder:

- []()
