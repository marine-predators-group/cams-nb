#!/usr/bin/env bash

# A script to simplify sbatch job submission
# Run script in the following fashion:
# bash sbatch_job_submission.sh <sbatch script file>

# Script will automatically submit to proper SBATCH account/partition
# based on what's entered in the script header.

# Read in user-supplied file
sbatch_script="$1"

# Extract account and partition names from suppllied SBATCH script.
account=$(grep "\-\-account" "${sbatch_script}" | awk -F "=" '{print $2}')
partition=$(grep "\-\-partition" "${sbatch_script}" | awk -F "=" '{print $2}')

# Execute SBATCH job submission.
sbatch \
-p "${partition}" \
-A "${account}" \
"${sbatch_script}"
