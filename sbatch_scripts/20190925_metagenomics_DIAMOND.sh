#!/bin/bash
## Job Name
#SBATCH --job-name=metagenomics_DIAMOND
## Allocation Definition
#SBATCH --account=coenv
#SBATCH --partition=coenv
## Resources
## Nodes
#SBATCH --nodes=1
## Walltime (days-hours:minutes:seconds format)
#SBATCH --time=10-00:00:00
## Memory per node
#SBATCH --mem=120G
##turn on e-mail notification
#SBATCH --mail-type=ALL
#SBATCH --mail-user=samwhite@uw.edu
## Specify the working directory for this job
#SBATCH --chdir=/gscratch/scrubbed/samwhite/outputs/20190925_metagenomics_DIAMOND

# Exit script if any command fails
set -e

# Load Python Mox module for Python module availability

module load intel-python3_2017

# SegFault fix?
export THREADS_DAEMON_MODEL=1

# Set working dir
wd=$(pwd)

# Program paths
diamond=

# DIAMOND NCBI nr database
dmnd=/gscratch/srlab/blastdbs/ncbi-nr-20190925/nr.dmnd


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
