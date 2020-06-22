#!/bin/bash

source ./.env
appName=$0

usage() {
    echo $1
    echo "Usage: $appName deploy <project_name>"
    exit 2
}

do_sync() {
    targetDir=${PROJECT["$2_TARGET"]}
    rsyncParam=${PROJECT["$2_PARAM"]}

    if [[ ! -e $targetDir ]]
    then
        usage "target directory '$targetDir' not found!"
    fi

    rsync $1 $rsyncParam ./ $targetDir
}

deploy() {
    if [[ -z ${PROJECT["$1_TARGET"]} ]]
    then
        usage "project_name '$1' not found in env vars"
    fi

    if $DRY_RUN
    then
        do_sync "-rvun" $1
    else
        do_sync "-rvu" $1
    fi
}

# just print the message
echo $2

case $1 in
    deploy)
        if [[ -n $2 ]]
        then
            deploy $2
        else
            usage "Invalid project_name!"
        fi
        ;;
    *)
        usage "Invalid syntax!"
        ;;
esac