#!/bin/bash

trap ctrl_c INT

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi
#if [ -z "$2" ]
#  then
#    sz = $2
#fi
url="$1"
fn=${url##*/}
echo Downloading $fn from $url
for i in {0..5};
do
echo $((2*$i))'0000000-'$((2*$i))'9999999'
curl -f -r $((2*$i))'0000000'-$((2*$i))'9999999' -o ~/down/$fn$((2*$i)) $url &
curl -f -r $((2*$i+1))'0000000'-$((2*$i+1))'9999999' -o ~/down/$fn$((2*$i+1)) $url &
wait $(jobs -p)
done;


function ctrl_c() {
        echo "** Trapped CTRL-C"
        kill $(jobs -p)
}
