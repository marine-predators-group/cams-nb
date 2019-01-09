#!/usr/bin/env bash


read sbatch_script


account=$(grep "\-\-account" ${sbatch_script} | awk -F "=" '{print $2}')
partition=$(grep "\-\-partition" ${sbatch_script} | awk -F "=" '{print $2}')

sbatch \
-p ${partition} \
-A ${account} \
${sbatch_script}
