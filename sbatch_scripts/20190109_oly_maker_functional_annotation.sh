#!/bin/bash
## Job Name
#SBATCH --job-name=maker
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=15-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --workdir=/gscratch/scrubbed/samwhite/outputs/20190109_oly_maker_functional_annotation

# Load Python Mox module for Python module availability

module load intel-python3_2017

# Load Open MPI module for parallel, multi-node processing

module load icc_19-ompi_3.1.2

# SegFault fix?
export THREADS_DAEMON_MODEL=1

# Document programs in PATH (primarily for program version ID)

date >> system_path.log
echo "" >> system_path.log
echo "System PATH for $SLURM_JOB_ID" >> system_path.log
echo "" >> system_path.log
printf "%0.s-" {1..10} >> system_path.log
echo ${PATH} | tr : \\n >> system_path.log

# Variables
maker_dir=/gscratch/srlab/programs/maker-2.31.10/bin

maker_prot_fasta=/gscratch/scrubbed/samwhite/outputs/20190108_oly_maker_id_mapping/20181127_oly_genome_snap02.all.maker.proteins.renamed.fasta
maker_put_prot_fasta=20181127_oly_genome_snap02.all.maker.proteins.renamed.putative_function.fasta
maker_transcripts_fasta=/gscratch/scrubbed/samwhite/outputs/20190108_oly_maker_id_mapping/20181127_oly_genome_snap02.all.maker.transcripts.renamed.fasta
maker_put_transcripts_fasta=20181127_oly_genome_snap02.all.maker.transcripts.renamed.putative_function.fasta
snap02_gff=/gscratch/scrubbed/samwhite/outputs/20190108_oly_maker_id_mapping/20181127_oly_genome_snap02.all.renamed.gff
snap02_put_gff=20181127_oly_genome_snap02.all.renamed.putative_function.gff
snap02_put_domains_gff=20181127_oly_genome_snap02.all.renamed.putative_function.domain_added.gff
snap02_put_domains_visible_gff=20181127_oly_genome_snap02.all.renamed.visible_ips_domains.gff
blastp_out=/gscratch/scrubbed/samwhite/outputs/20190108_oly_maker_blastp/20190108_blastp.outfmt6
maker_ips=/gscratch/scrubbed/samwhite/outputs/20190108_oly_maker_interproscan/20190108_oly_maker_proteins_ips.tsv
sp_db=/gscratch/srlab/blastdbs/UniProtKB_20190109/uniprot_sprot.fasta



## Add putative gene functions
### GFF
${maker_dir}/maker_functional_gff \
${sp_db} \
${blastp_out} \
${snap02_gff} \
> ${snap02_put_gff}

### Proteins
${maker_dir}/maker_functional_fasta \
${sp_db} \
${blastp_out} \
${maker_prot_fasta} \
> ${maker_put_prot_fasta}

### Transcripts
${maker_dir}/maker_functional_fasta \
${sp_db} \
${blastp_out} \
${maker_transcripts_fasta} \
> ${maker_put_transcripts_fasta}

## Add InterProScan domain info
### Add searchable tags
${maker_dir}/ipr_update_gff \
${snap02_put_gff} \
${maker_ips} \
> ${snap02_put_domains_gff}

### Add viewable features for genome browsers (JBrowse, Gbrowse, Web Apollo)
${maker_dir}/iprscan2gff3 \
${maker_ips} \
${snap02_gff} \
> ${snap02_put_domains_visible_gff}
