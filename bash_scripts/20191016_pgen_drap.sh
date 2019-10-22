#!/bin/bash

# Bash script for downloading geoduck RNAseq files
# These are intended to be analyzed using DRAP (a program for generating and combining)
# transcriptomes from different tissue types, treatments, etc.

# All RNAseq FastQ files are available here:
# https://owl.fish.washington.edu/nightingales/P_generosa/

# Download files
rsync -av --progress "${rsync_path}"/*RNA*.gz .
rsync -av --progress "${rsync_path}"/NR0[012][12569]*.gz .

rsync_path="owl:/volume1/web/nightingales/P_generosa"


# Set array values for tissue, treatment, and "NR" filenames
tissues_array=(ctenidia gonad heart juvenile larvae)
treatment_array=(ambient OA)
nr_files_array=(NR005 NR006 NR012 NR015 NR019 NR021)


# Make directories
for tissue in "${tissues_array[@]}"
do
	if [ "${tissue}" == "juvenile" ]; then
	  	for treatment in "${treatment_array[@]}"
			do
					mkdir --parents "${tissue}"/"${treatment}"
			done
	else
		mkdir "${tissue}"
	fi
done

# Move files to appropriate directory
for fastq in *.gz
do
	nr_check=$(echo "${fastq}" | awk -F"_" '{ print $1 }')
	tissue_check=$(echo "${fastq}" | awk -F"-" ' { print $2 }')
	treatment_check=$(echo "${fastq}" | awk -F"-" ' { print $2 "-" $3 }')

	for tissue in "${tissues_array[@]}"
	do
		if [[ "${tissue}" == "juvenile" ]]; then
			for nr_tissue in "${nr_files_array[@]}"
			do
				if [[ "${nr_check}" == "NR005" ]] \
				|| [[ "${nr_check}" == "NR019" ]]; then
		  	for treatment in "${treatment_array[@]}"
				do
						if [[ "${treatment_check}" == "${tissue}-${treatment}" ]]; then
							mv "${fastq}" "${tissue}"/"${treatment}"
						fi
				done
			elif [[ "${nr_check}" == "NR006" ]]; then
					mv "${fastq}" "gonad"
				elif [[ "${nr_check}" == "NR012" ]]; then
					mv "${fastq}" "ctenidia"
				elif [[ "${nr_check}" == "NR021" ]]; then
					mv "${fastq}" "larvae"
			  fi
			done
		else
			if [[ "${tissue}" == "${tissue_check}" ]]; then
				mv "${fastq}" "${tissue}"
			fi
		fi
	done
done
