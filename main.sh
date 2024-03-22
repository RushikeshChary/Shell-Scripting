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
echo "------------------" >> "$output_file"
echo "Unique cities in the given data file:" >> "$output_file"
# printing the unique cities from the input file to the output file
# Here, with NR>1, we are ignoring the first row(i.e, headers) from input file and taking the 3rd column -> pipe to sort -> pipe to uniq(to remove duplicates) -> pip to sed to remove trailing spaces.
awk -F, 'NR>1{print $3}' $input_file | sort | uniq | sed 's/^[ \t]*//' >> $output_file

#Individuals details with top 3 highest salary.
echo "------------------" >> "$output_file"
echo "Details of top 3 individuals with the highest salary:" >> "$output_file"
# Here, we use sed 1d to ignore the first row(i.e., headers). pipe to sort with key value(i.e., k4) as the 4th column values in descending order(i.e., -nr) -> pipe to head (to get top 3 values) -> pipe to get output individual details in ascending order of their names.
sed '1d' "$input_file"  | sort -t',' -k4 -nr | head -n 3 | sort -t',' -k1  >> "$output_file"

#Average salary in each city.
echo "------------------" >> "$output_file"
echo "Details of average salary of each city:" >> "$output_file"
# Here, we use awk tools. First ignore headers with NR>1 and then make a list with cities as indeces and total salary as the values. Also make a count array. Now, we can get average salary for each city with these values.
awk -F, 'NR==1 {next} {sum[$3] += $4; count[$3]++} END {for (city in sum) {print "City:" city ", Salary: " sum[city] / count[city]}}' "$input_file" >> "$output_file"

# Identify individuals with a salary above the overall average salary
echo "------------------" >> "$output_file"
echo "Details of individuals with a salary above the overall average salary:" >> "$output_file"
#Calculating the overall average salary with awk command and storing average in a variable here.
avg=$(awk -F, 'NR==1 {next} {sum += $4; count++} END {print sum / count}' "$input_file")
# With the help of awk variable, we can get overall average computed above and use it to compare with individual salaries and print the individuls with salary above the overall average salary.
awk -F, -v avg="$avg" 'NR>1 && $4 > avg {print $1, $2, $3, $4}' $input_file >> $output_file
#Last dashed line.
echo "------------------" >> "$output_file"

# An output to the terminal after completion of the execution.
echo "Execution is done. Check your output file - $output_file"
