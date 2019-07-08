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
[Earlier today, I generated the necessary Hista2 index, which incorporated splice sites and exons](https://robertslab.github.io/sams-notebook/2019/06/25/Genome-Annotation-O.lurida-(v081)-Hisat2-Transcript-Isoforms-Index.html) for use with Stringtie in order to identify transcript isoforms in our [Olurida_v081 annotation](https://robertslab.github.io/sams-notebook/2019/01/09/Annotation-Olurida_v081-MAKER-Functional-Annotations-on-Mox.html).

Command to pull trimmed files:

```shell
tar -ztvf trinity_out_dir.tar.gz \
| grep -E "*P.qtrim.gz" \
&& tar -zxvf trinity_out_dir.tar.gz \
-C /home/sam/Downloads/ \
--wildcards "*P.qtrim.gz"
```

SBATCH script (GitHub):

- [20190625_stringtie_oly_v081.sh](https://github.com/RobertsLab/sams-notebook/blob/master/sbatch_scripts/20190625_stringtie_oly_v081.sh)

```shell
#!/bin/bash
## Job Name
#SBATCH --job-name=oly_stringtie
## Allocation Definition
#SBATCH --account=srlab
#SBATCH --partition=srlab
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=25-00:00:00
## Memory per node
#SBATCH --mem=500G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190625_stringtie_oly_v081

# Exit script if any command fails
set -e

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo "${PATH}" | tr : \\n >> system_path.log


threads=27
genome_index_name="Olurida_v081"

# Paths to programs
hisat2_dir="/gscratch/srlab/programs/hisat2-2.1.0"
hisat2="${hisat2_dir}/hisat2"
samtools="/gscratch/srlab/programs/samtools-1.9/samtools"
stringtie="/gscratch/srlab/programs/stringtie-1.3.6.Linux_x86_64/stringtie"

# Input/output files
genome_gff="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081/20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff"
genome_index_dir="/gscratch/srlab/sam/data/O_lurida/genomes/Olurida_v081"
fastq_dir="/gscratch/srlab/sam/data/O_lurida/RNAseq/"
gtf_list="gtf_list.txt"

## Inititalize arrays
fastq_array_R1=()
fastq_array_R2=()
names_array=()

# Copy Hisat2 genome index
rsync -av "${genome_index_dir}"/Olurida_v081*.ht2 .

# Create array of fastq R1 files
for fastq in ${fastq_dir}*R1*.gz
do
  fastq_array_R1+=(${fastq})
done

# Create array of fastq R2 files
for fastq in ${fastq_dir}*R2*.gz
do
  fastq_array_R2+=(${fastq})
done

# Create array of sample names
## Uses parameter substitution to strip leading path from filename
## Uses awk to parse out sample name from filename
for R1_fastq in ${fastq_dir}*R1*.gz
do
  names_array+=($(echo ${R1_fastq#${fastq_dir}} | awk -F"[_.]" '{print $1 "_" $5}'))
done

# Create list of fastq files used in analysis
## Uses parameter substitution to strip leading path from filename
for fastq in ${fastq_dir}*.gz
do
  echo "${fastq#${fastq_dir}}" >> fastq.list.txt
done

# Hisat2 alignments
for index in "${!fastq_array_R1[@]}"
do
  sample_name=$(echo "${names_array[index]}")
  "${hisat2}" \
  -x "${genome_index_name}" \
  --downstream-transcriptome-assembly \
  -1 "${fastq_array_R1[index]}" \
  -2 "${fastq_array_R2[index]}" \
  -S "${sample_name}".sam \
  2> "${sample_name}"_hisat2.err
# Sort SAM files, convert to BAM, and index
  "${samtools}" view \
  -@ "${threads}" \
  -Su "${sample_name}".sam \
  | "${samtools}" sort - \
  -@ "${threads}" \
  -o "${sample_name}".sorted.bam
  "${samtools}" index "${sample_name}".sorted.bam

# Run stringtie on alignments
  "${stringtie}" "${sample_name}".sorted.bam \
  -p "${threads}" \
  -o "${sample_name}".gtf \
  -G "${genome_gff}" \
  -C "${sample_name}.cov_refs.gtf"
# Add GTFs to list file
  echo "${sample_name}.gtf" >> "${gtf_list}"
done

# Create singular transcript file, using GTF list file
"${stringtie}" --merge \
"${gtf_list}" \
-p "${threads}" \
-G "${genome_gff}" \
-o "${genome_index_name}".stringtie.gtf

# Delete unneccessary index files
rm Olurida_v081*.ht2

# Delete unneded SAM files
rm *.sam
```

---

#### RESULTS

Output folder:

- [20190625_stringtie_oly_v081/](https://gannet.fish.washington.edu/Atumefaciens/20190625_stringtie_oly_v081/)
