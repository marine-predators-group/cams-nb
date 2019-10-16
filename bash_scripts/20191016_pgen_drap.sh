#!/bin/bash


# All RNAseq FastQ files are available here:
# https://owl.fish.washington.edu/nightingales/P_generosa/



rsync_path="owl:/volume1/web/nightingales/P_generosa"



tissues_array=(ctenidia gonad heart juvenile larvae)
treatment_array=(ambient OA)


# Make directories
for tissue in ${tissues_array[@]}
do
	if [ "${tissue}" == "juvenile" ] \
	|| ["${tissue}" == "larvae" ]; then \
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
