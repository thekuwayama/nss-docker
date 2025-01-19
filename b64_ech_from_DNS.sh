#!/bin/bash
host=$1
ECHRR=`dig +short -t TYPE65 $host | cut -f 3- -d' ' | tr -d " "`
if [[ "$ECHRR" == "" ]]
then
    echo "Can't read ECHConfigList for $host"
    exit 2
fi
# extract ECHConfigs from RR
marker="FE0D"
prefix=${ECHRR%%$marker*}
index=${#prefix}
ec_ah_ind=$((index-4))
e_ah_len=${ECHRR:ec_ah_ind:4}
ech_len=$(((2*(16#$e_ah_len+4))-3))
ech_str=${ECHRR:ec_ah_ind:ech_len}
ECH=`echo $ech_str | xxd -r -p | base64`
echo $ECH
