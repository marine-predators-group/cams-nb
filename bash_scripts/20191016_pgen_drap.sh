#!/bin/bash



tissues_array=(ctenidia gonad heart juvenile larvae)

treatment_array=(ambient OA)



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
