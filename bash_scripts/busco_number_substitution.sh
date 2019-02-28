#!/bin/env bash

########################
# Script to parse the number from the Augustus ```augustus_output/retraining_parameters``` files.

# User needs to change these two variables to match their current project:

#-------------------------------------------------
# Set basename
base_name="Pgenerosa_v071_genome_snap02.all.maker"

## Set species variable
species="Panopea_generosa"
#-------------------------------------------------

# Works on the value provided to ```--out <out_name>``` supplied to BUSCO (let's assign to variable called ```${base_name}```)

# Run from the augustus_output/retraining_parameters directory

#######################

## Set "\_" as a delimiter
delim="_"

## Save filename as string
string=$(echo *_parameters.cfg)

## Save number for eventual subsitution
## Saves the second to last field (```$(NF-1)```), which is that BUSCO number
busco_num=$(awk -F"${delim}" '{print $(NF-1)}' <<< ${string})

## Use paremeter subsitution to match pattern (designated by the '#') and replace with patter that follows the '/'
## E.g. produces files named ```Panopea_generosa_parameters.cfg```
for file in BUSCO*
do
  mv ${file} "${file/#BUSCO_${base_name}_${busco_num}/${species}}"
done

## Substitute new naming scheme into config files
for config in *_parameters*
do
sed -i "s/BUSCO_${base_name}_${busco_num}/${species}/g" ${config}
