#!/usr/bin/env bash


read sbatch


account=$(grep "\-\-account" ${sbatch} | awk -F "=" '{print $2}')
partition=$(grep "\-\-partition" ${sbatch} | awk -F "=" '{print $2}')
