#!/bin/bash

echo -e "\n"

echo "==========================="
echo "SENTINAL -- REPORT        ="
echo "==========================="
 
total_count=0
files=$(find . -name "*.logs")

for file in $files;do
	count=$(wc -l < "$file")
	total_count=$((total_count+count))
done

file_count=$(find . -name "*.logs" | wc -l)

echo -e "\n"


echo "-----------------------------------------------"

echo "STATUS : SCAN COMPLETE ! "
echo "TOTAL LOGS : $total_count"
echo "FILES EVALUATED : $file_count"

echo "-----------------------------------------------"


for file in $files;do

	echo -e "\n"
	echo "Report for file -- ${file}"
	echo "*************************************"
	echo -e "\n"

	   ip=$(awk '
	   		/failed|error|warn|denied|drop|401/i {
		     for(i=1 ; i<=NF ; i++){
			     n=split($i,parts,/[:=]/)
				 for(j=1; j<=n; j++)
			     if (parts[j] ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/){
			     	count[parts[j]]++ }
					}
		          }
				  
			END {
			for (ip in count){
				if (count[ip] >= 3 && count[ip] < 5) {
					print "[MEDIUM]", "\n" "IP :" ip, "\n" "Attempts : " count[ip]
				}
				if (count[ip] >= 5){
					print "[HIGH]","\n" "IP : " ip,"\n" "Attempts : " count[ip]
				}

				}


				
			}' "$file")

		
			
				

		ip_count=$(printf '%s\n' "$ip" | grep -c .)


		if [ -n "$ip" ];then
			echo "$ip"
		else
			echo "NO Suspecious Activity Detected"
		fi
		

	echo -e "\n"
	echo -e "\n"
done

echo "List of Essential Logs : "
echo "*************************"

for file in $files;do
	echo -e "\n"

	echo "============================"
	echo "File : ${file[@]} :"
    echo "============================"

	echo -e "\n"

	echo "Total logs in this file :  $(wc -l < ${file}) "
	echo "------------------------------"

	echo -e "\n"
	


	grep -Ein "failed|error|drop|warn|401|denied|suspicious|established" "$file"

	echo -e "\n"

	echo "*************************************************************************************************************"

done
