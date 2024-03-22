# Shell Scripting
Its a simple shell script assignment (of course CS253) using sed, awk and some other tools to scrap a specific type of data from given CSV file.
Read the question in this [pdf](https://github.com/RushikeshChary/Shell-Scripting/blob/main/2024_shell_scripting_assignment.pdf) to get more information.
The given output.txt file is example of how an ouput file will be generated.
## Usage
Make sure to check whether the file main.sh has required permissions to be executable.
If not, run the following command.
```bash
chmod +x main.sh
```

## Arguments
Make sure that you send all arguments to the shell script (i.e., input file(csv) and output file(any txt file into with you wish to get your output)).
The following is the way to send these as the arguments.
```bash
./main.sh data.csv output_file.txt
```
If input is missing, the script will exit with error or if the arguments are incorrect, the script will show you the correct way to use it and exit.
(Make sure that your input file is in same directory as script file.)
