#!/bin/bash


# All RNAseq FastQ files are available here:
# https://owl.fish.washington.edu/nightingales/P_generosa/



rsync_path="owl:/volume1/web/nightingales/P_generosa"



tissues_array=(ctenidia gonad heart juvenile larvae)
treatment_array=(ambient OA)
nr_files_array=(NR005 NR006 NR012 NR015 NR019 NR021)
tissue_files_array=()
treatement_files_array=()

# Make directories
for tissue in ${tissues_array[@]}
do
	if [ "${tissue}" == "juvenile" ]; then
	  	for treatment in ${treatment_array[@]}
			do
					mkdir --parents ${tissue}/${treatment}
			done
	else
		mkdir ${tissue}
	fi
done

# Download files
rsync -av --progress "${rsync_path}"/*RNA*.gz .
rsync -av --progress "${rsync_path}"/NR0[012][12569]*.gz .

# Move files to appropriate directory
for fastq in *.gz
do
	nr_check=$(echo "${fastq}" | awk -F"_" '{ print $1 }')
	tissue_check=$(echo "${fastq}" | awk -F"-" ' { print $2 }')
	treatment_check=$(echo "${fastq}" | awk -F"-" ' { print $2 "-" $3 }')

	for tissue in ${tissues_array[@]}
	do
		if [[ "${tissue}" == "juvenile" ]]; then
		  	for treatment in ${treatment_array[@]}
				do
						if [[ "${treatment_check}" == "${tissue}-${treatment}" ]]; then
							mv "${fastq}" ${tissue}/${treatment}
						fi
				done
		else
			if [[ "${tissue}" == "${tissue_check}" ]]; then
				mv "${fastq}" "${tissue}"
			fi
		fi
	done

	for nr_tissue in ${nr_files_array[@]}
	do
		for tissue in ${tissues_array[@]}
		if [[ "${nr_tissue}" == "NR005"]]; then
			mv ${fastq} "${}"
		fi

done
