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
        ## Add commands here
        echo 'masscan not installed'
        echo installing
        exit
    else
        :
        echo 'masscan installed'
        #return 0
    fi

}


function check_nrich()
{
    if ! [ -x "$(command -v nrich)" ]
    then
        :
        #installing masscan 
        ## Add commands here
        echo 'nrich not installed'
        echo installing
        exit
    else
        :
        echo 'nrich installed'
        #return 0
    fi

}

function check_inputFile()
{
    inputFile="$1"
    if [ -f "${inputFile}" ] &&  grep -q -E '[0-9]{1,3}(?:\.[0-9]{1,3}){0,3}\/[0-9]+' "${inputFile}"; then
        echo "${inputFile} exists and in valid format"
        return 0
    else 
        echo "${inputFile} does not exist or invalid format"
        exit
    fi
}


masscan_scan()
{
    sudo masscan -iL "$1" --excludeFile AntiScanIPList.txt --top-ports 20 ---max-rate 100000 -oG masscan_output.txt 2>|./masscan.error_log.log
}

extract_ip_masscan()
{
    while IFS= read -r line || [[ -n "$line" ]]; do
        awk '{print $4}' >> nrich_input.txt
    done < masscan_output.txt
}

nrich_scan_json()
{
    nrich --output json nrich_input.txt 1>|./enmass3_output.json 2>|./nrich.error_log.log
}

nrich_scan_shell()
{
    nrich --output shell nrich_input.txt 1>|./enmass3_output.txt 2>|./nrich.error_log.log
}

trapcleanup()
{
    echo 'trapped, die!!!!!!!!'
}

main()
{
    trap trapcleanup INT TERM ERR
    clear
	echo "Run as sudo"

    # add argv1 enmass.txt "$1"

    # check depenadancies
    if check_masscan && check_nrich ; then
        :
        echo " -> All Dependancies Installed..."
        # check meta input file
        if check_inputFile "$@" ; then
            :
            echo " -> All checks done"
            # running masscan
            masscan_scan "$@"
            # extract ips from grepable masscan
            extract_ip_masscan
            # running nrich
            nrich_scan_json
            nrich_scan_shell
        fi
    fi
}






# set -x																	# set Debug
# for source issues
if ! (return 0 2> /dev/null); then 
    main "$@"
fi
# set +x																	# unset Debug

