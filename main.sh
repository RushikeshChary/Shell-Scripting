#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <input_file> <output_file>"
	exit 1
fi

input_file=$1
output_file=$2

if [ ! -f "$input_file" ]; then
	echo "Error: Given input file - $input_file is not found."
	exit 1
fi

#Unique cities in the input file.

echo "--------------------------" >> "$output_file"
echo "Unique cities in the given data file:" >> "$output_file"

# cut -d',' -f3 "$input_file" | sed '1d' | sort -u >> "$output_file"
# printing the unique cities from the input file to the output file
awk -F, 'NR>1{print $3}' $input_file | sort | uniq | sed 's/^[ \t]*//' >> $output_file

#Individuals details with top 3 highest salary.

echo "--------------------------" >> "$output_file"
echo "Details of top 3 individuals with the highest salary:" >> "$output_file"

sed '1d' "$input_file"  | sort -t',' -k4 -nr | head -n 3 >> "$output_file"

#Average salary in each city.

echo "--------------------------" >> "$output_file"
echo "Details of average salary of each city:" >> "$output_file"

awk -F',' 'NR>1 {sum[$3]+=$4; count[$3]++} END {for(city in sum) print "City:", city, ", Salary:" sum[city]/count[city]}' "$input_file"  >> "$output_file"

#Individuals with salary above overall average .

# echo "------------------
# Details of individuals with a salary above the overall average salary: " >> "$output_file"
# awk -F, 'NR>1{sum+=$4; count++} END{avg=sum/count} {if($4>avg) print $1, $2, $3, $4}' "$input_file" >> "$output_file"


# Identify individuals with a salary above the overall average salary
echo "--------------------------" >> "$output_file"
echo "Details of individuals with a salary above the overall average salary:" >> "$output_file"
#Calculating the overall average salary and storing average in a variable here.
avg=$(awk -F, 'NR==1 {next} {s += $4; ct++} END {print s / ct}' "$input_file")
awk -F, -v avg="$avg" 'NR>1 && $4 > avg {print $1, $2, $3, $4}' $input_file | sed 's/above/over/' >> $output_file


#Last dashed line.
echo "----------------------------" >> "$output_file"

echo "Execution is done. Check your output file - $output_file"
