#!/usr/bin/env bash


# Read in user-supplied file
sbatch_script="$1"

# Extract account and partition names from suppllied SBATCH script.
account=$(grep "\-\-account" ${sbatch_script} | awk -F "=" '{print $2}')
partition=$(grep "\-\-partition" ${sbatch_script} | awk -F "=" '{print $2}')

# Execute SBATCH job submission.
sbatch \
-p ${partition} \
-A ${account} \
${sbatch_script}
