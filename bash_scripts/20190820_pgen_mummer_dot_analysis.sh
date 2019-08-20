#!/bin/bash

# Script for downloading Pgenerosa_v074 MUMMER delta files and creating "Dot" coordinate files
# for visualization: https://dnanexus.github.io/dot/


nucmer_delta_rsync="/volume2/web/Atumefaciens/20190807*/*.delta"
promer_delta_rsync="/volume2/web/Atumefaciens/20190813*/*.delta"



# Make output directories
mkdir nucmer_delta promer_delta

# Download nucloetide MUMMER delta files
cd "${nucmer_delta}" \
&& rsync -av --progress "${nucmer_delta_rsync}" .


# Download nucloetide MUMMER delta files
cd ../"${promer_delta}" \
&& rsync -av --progress "${promer_delta_rsync}" .

# Looop through directories and run DotPrep.py on each delta file
for folder in *delta/
do
	cd "${folder}"
  for delta in *.delta
	do
		../DotPrep.py \
		--delta "${delta}" \
		--out "${timestamp}"_"${dir}"_${comparison}.coords.dot
	done
	cd ..
done
