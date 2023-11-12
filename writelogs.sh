#!/bin/bash
#write logs in file
#author:liuzhen
#version 1.0
#2016/1/25



export LANG=en_US.UTF-8

function  usage()
{
echo "usage:  sh  $0 -f logfile -l lvevl [DEBUG|INFO|WARNING|ERROR] -m \"message\" "
}

if [[ "$#" -eq 0 ]]
   then
       usage
       exit 1
fi

while getopts f:l:m:h OPTION
do
    case "$OPTION" in
        f)LOG_FILE=$OPTARG
        ;;
	l)LOG_LEVEL=$OPTARG
	;;
        m)LOG_MESSAGE=$OPTARG
        ;;
        h)usage
        exit 0
        ;;
        *)
        usage
        exit 1
        ;;
    esac
done

LOG_TIME=`date "+%Y-%m-%d %T.%N"`

LOG_PATH=`echo ${LOG_FILE} | awk -F'/' '{for(i=1;i<NF;i++)printf("%s/",$i)}'`
if [ !  -d "${LOG_PATH}" ]
then
    echo "${LOG_TIME} [ERROR] ${LOG_PATH} not exist."
    exit 1
fi

LOG_LEVEL_UPPER=`echo "${LOG_LEVEL}" | tr '[:lower:]' '[:upper:]'`
if [ "${LOG_LEVEL_UPPER}" = "DEBUG" ] || [ "${LOG_LEVEL_UPPER}" = "INFO" ] || [ "${LOG_LEVEL_UPPER}" = "WARNING" ] || [ "${LOG_LEVEL_UPPER}" = "ERROR" ] 
then
    echo >/dev/null
else
    echo "${LOG_TIME} [ERROR] ${LOG_LEVEL} not defined."
    exit 1
fi

echo "${LOG_TIME} [${LOG_LEVEL_UPPER}] ${LOG_MESSAGE}" >> ${LOG_FILE}
