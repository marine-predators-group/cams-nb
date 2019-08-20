#!/bin/bash

# Script for downloading Pgenerosa_v074 MUMMER delta files and creating "Dot" coordinate files
# for visualization: https://dnanexus.github.io/dot/


# Capture date. E.g. format is: 20190820
timestamp=$(date +"%Y%m%d")

nucmer_delta_rsync="/volume2/web/Atumefaciens/20190807*/*.delta"
promer_delta_rsync="/volume2/web/Atumefaciens/20190813*/*.delta"



# Make output directories
mkdir nucmer_delta promer_delta

# Download nucloetide MUMMER delta files
cd nucmer_delta \
&& rsync -av --progress "${nucmer_delta_rsync}" .


# Download nucloetide MUMMER delta files
cd ../promer_delta \
&& rsync -av --progress "${promer_delta_rsync}" .

# Looop through directories and run DotPrep.py on each delta file
for folder in *delta/
do
	mummer=$(echo "${folder}" | awk -F"_" '{ print $1 }')
	cd "${folder}" || exit
  for delta in *.delta
	do
		comparison=$(echo "${delta}" | awk -F"." '{ print $1 }')
		../DotPrep.py \
		--delta "${delta}" \
		--out "${timestamp}"_"${mummer}"_"${comparison}".coords.dot
	done
	cd ..
done
