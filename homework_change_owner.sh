#!/bin/bash
args_quantity=$#
user_arg=$1
folder_arg=$2

print_help() {
  echo -e "\e[0;32m"
	echo "Usage: $0 { arg_1 } { arg_2 } "
	echo
	echo " -h, --help - print out an internal help"
  echo " arg_1 - user name for changing folder ownership"
  echo " arg_2 - name of directory for which we must change ownership"
	echo -e "\e[0m"
  exit 1
}

if [ $args_quantity -gt 2 ] 
then
		echo -e "\e[0;31m"		
		echo "Please, use no more, then 2 arguments!!!"
		echo "========================================"
		echo -e "\e[0m"
		print_help
fi

if [ $args_quantity -eq 0 ]
then
		print_help
fi

if [ $args_quantity -eq 1 ]
then
	case $user_arg in
		-h | --help)
						print_help
						;;
		-* | --*)
						echo -e "\e[0;31m"
						echo "Error: Uknown option: $user_arg" >&2
						echo "========================"
						echo -e "\e[0m"
						print_help
						;;
		*)
						echo -e "\e[0;31m"
						echo "One argument isn't applicable option. Please, read help down below!"
						echo "==================================================================="
						echo -e "\e[0m"
						print_help
						;;
	esac
fi

user_validation() {

getent passwd $user_arg > /dev/null

if [ $? -eq 0 ]; then
				echo 'User validation: => exists'
else
				echo 'User validation: => not found'
				exit 1
fi
}

folder_validation() { 

if [ -d $folder_arg ]; then
				echo 'Folder validation: => exists'
else 
				echo 'Folder validation: => absent'
				exit 1
fi
}

# if number of arguments == 2 
if [ $args_quantity -eq 2 ]
then	
user_validation 
folder_validation

# change ownership
chown -R $user_arg:$user_arg $folder_arg

fi

echo -e "\e[0;32m"
echo "Script result is down below:" 
echo "------------------------------"

#list all results to the console
ls -lR $folder_arg 
