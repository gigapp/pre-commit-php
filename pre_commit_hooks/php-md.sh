#!/bin/bash

# Bash PHP Mess Detector Hook
#
# Exit 0 if no errors found
# Exit 1 if errors were found
#
# Requires
# - php
#
# Arguments
# - None

# Echo Colors
msg_color_magenta='\033[1;35m'
msg_color_yellow='\033[0;33m'
msg_color_none='\033[0m' # No Color

# Loop through the list of paths to run PHPMD against
echo -en "${msg_color_yellow}Begin PHP Mess Detector ...${msg_color_none} \n"
phpmd_local_exec="phpmd.phar"
phpmd_command="php $phpmd_local_exec"

# Check vendor/bin/phpunit
phpmd_vendor_command="vendor/bin/phpmd"
phpmd_global_command="phpmd"
if [ -f "$phpmd_vendor_command" ]; then
	phpmd_command=$phpmd_vendor_command
else
    if hash phpmd 2>/dev/null; then
        phpmd_command=$phpmd_global_command
    else
        if [ -f "$phpmd_local_exec" ]; then
            phpmd_command=$phpmd_command
        else
            echo "No valid PHP Mess Detector executable found! Please have one available as either $phpmd_vendor_command, $phpmd_global_command or $phpmd_local_exec"
            exit 1
        fi
    fi
fi

phpmd_files_to_check="${@:2}"                        # wiki.bash-hackers.org/scripting/posparams#range_of_positional_parameters
phpmd_files_to_check="${phpmd_files_to_check// /,}"  # tldp.org/LDP/abs/html/string-manipulation.html -- Substring Replacement
phpmd_report_format="text"
phpmd_args=$1
phpmd_command="$phpmd_command $phpmd_files_to_check $phpmd_report_format $phpmd_args"

echo "Running command $phpmd_command"
command_result=`eval $phpmd_command`

if [ $? -ne 0 ]
then
    echo -en "${msg_color_magenta}Errors detected by PHP Mess Detector ... ${msg_color_none} \n"
    echo "$command_result"
    exit 1
fi

exit 0
