
# Configure user Bash
export PS1="\e[01;33m\u\e[00m:\e[01;33m\w\e[00m$ "
export PATH=$PATH
PATH="$PATH:/gnuarm-3.4.3/bin"
alias arm="arm-elf-gcc -S"
alias gcc="arm-elf-gcc -Wall -Wextra -g"
alias gdb="arm-elf-gdb -tui --command=/home/student/.gdbinit/default"
alias e7t="arm-elf-gdb -tui --command=/home/student/.gdbinit/evaluator7t"
cd /home/student/src
