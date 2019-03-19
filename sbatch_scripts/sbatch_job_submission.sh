#!/usr/bin/env bash

# Extract account and partition names from suppllied SBATCH script.
## Back slashes escape the hyphens
## Parses out account (e.g. srlab or coenv)
## Parses out partition (e.g. srlab or coenv)
script_location=$(grep "\-\-workdir" | awk -F "=" '{print $2}')
account=$(grep "\-\-account" ${sbatch_script} | awk -F "=" '{print $2}')
partition=$(grep "\-\-partition" ${sbatch_script} | awk -F "=" '{print $2}')

# Complete name of script_location
sbatch_script=${script_location}.sh

# Execute SBATCH job submission.
## Submits job to account/partition specified in script
sbatch \
-p ${partition} \
-A ${account} \
${sbatch_script}
