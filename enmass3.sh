#!/usr/bin/env bash

#bash -n driver.sh 		# dry run for syntax
#bash -v driver.sh 	# trace
#bash -x driver.sh 	# more vergbose trace

#Fail safe
set -o errexit # fail on exit
set -o nounset # fail on variable issues
set -o pipefail # fail for pipe related stuff


function check_masscan()
{
    if ! [ -x "$(command -v masscan)" ]
    then
        :
        #installing masscan
        printf "Masscan is not installed, Installing it!!\n"
        #building from source
        #echo 'Installing Dependancies for masscan'
        #apt-get --assume-yes install git libpcap-dev make gcc 1>/dev/null 2>depenadancies.error_log.log
        #cd /opt && git clone https://github.com/robertdavidgraham/masscan 1>/dev/null 2>depenadancies.error_log.log
        #cd /opt/masscan && make 1>/dev/null 2>depenadancies.error_log.log
        
        #using repo
        apt install masscan 1>/dev/null 2>depenadancies.error_log.log
        printf "Masscan Installed\n"
        exit
    else
        :
        #echo 'masscan installed'
        #return 0
    fi

}


function check_nrich()
{
    if ! [ -x "$(command -v nrich)" ]
    then
        :
        #installing masscan 
        printf 'Nrich not installed\n'
        printf "installing nrich\n"
        apt install wget 1>/dev/null 2>depenadancies.error_log.log
        mkdir /opt/nrich && cd "$_" && wget https://gitlab.com/api/v4/projects/33695681/packages/generic/nrich/latest/nrich_latest_amd64.deb 1>/dev/null 2>depenadancies.error_log.log
        apt install /opt/nrich/nrich_latest_amd64.deb 1>/dev/null 2>depenadancies.error_log.log
        printf "Nrich Installed!"
        exit
    else
        :
        #echo 'nrich installed'
        #return 0
    fi

}

function check_jq()
{
    if ! [ -x "$(command -v jq)" ]
    then
        :
        #jq not found installing jq 
        printf 'JQ not installed\n'
        printf "Installing jq\n"
        apt install jq 1>/dev/null 2>depenadancies.error_log.log
        printf "jq Installed!"
        exit
    else
        :
        #echo 'jq already installed'
        #return 0
    fi

}

function check_inputFile()
{
    inputFile="$1"
    if [ -f "${inputFile}" ]; then
        echo "${inputFile} exists"

        if grep -q -E '[0-9]{1,3}(?:\.[0-9]{1,3}){0,3}\/[0-9]+' "${inputFile}"; then
            echo "${inputFile} format is valid"
            return 0
        else
            echo "${inputFile} has invalid IP CIDR blocks, provide one in a valid format"
        fi
    else 
        echo "${inputFile} does not exist, please provide a valid file name"
        exit
    fi
}


# function masscan_grepaableOutput()
# {
#     sudo masscan -iL "$1" --excludeFile AntiScanIPList.txt --top-ports 20 ---max-rate 100000 -oG masscan_output.txt 2>|./masscan.error_log.log
# }

function masscan_jsonOutput()
{
    sudo masscan -iL "$1" --excludeFile AntiScanIPList.txt --top-ports 20 ---max-rate 100000 -oJ masscan_output.json 2>|./masscan.error_log.log
}


# function extractIp_awk()
# {
#     while IFS= read -r line || [[ -n "$line" ]]; do
#         awk '{print $4}' >> nrich_input.txt
#     done < masscan_output.txt
# }

function extractIp_jq()
{
    jq -r '.[].ip' masscan_output.json >> nrich_input.txt
}


function nrich_scan_json()
{
    nrich --output json nrich_input.txt 1>|./enmass3_output.json 2>|./nrich.error_log.log
}

# function nrichScan_ndjson()
# {
#     nrich --output ndjson nrich_input.txt 1>|./enmass3.ndjson 2>|./nrich.error_log.log
# }

# function nrichScan_shell()
# {
#     nrich --output shell nrich_input.txt 1>|./enmass3.txt 2>|./nrich.error_log.log
# }


trapcleanup()
{
    #rm -f nrich_input.txt
    #rm -f 
    echo 'Trapped!'
}

main()
{
    trap trapcleanup INT TERM ERR
    clear

	# checking for sudo perms
    if [ "$EUID" -ne 0 ];then
        echo "Run the script as root"
        echo "Exitting..."
        exit
    fi

    # checking if inputfile is provided as a parameter
    [[ "$#" -eq "0" ]] && { echo "No inputfile provided"; exit 1; } || { var=$1; echo -n "${var:?No file}" "being used as the input file"; echo ""; }
    
    # check depenadancies
    if check_masscan && check_nrich ; then
        :
        #echo " -> All Dependancies Installed..."
        # check meta input file
        if check_inputFile "$@" ; then
            :
            #echo " -> All checks done"

            echo "Running masscan..."
            # running masscan
            masscan_jsonOutput "$1"
            
            echo "Extracting Ips"
            # extracting ips from json output
            extractIp_jq
            
            echo "Running nrich..."
            # running nrich
            nrich_scan_json

            echo "Scanning complete! Look at enmass3_output.json for the results"
            times
        fi
    fi
}






# set -x																	# set Debug
# for source issues
if ! (return 0 2> /dev/null); then 
    main "$@"
fi
# set +x																	# unset Debug

