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
for i in {0..25};
do
echo $((2*$i))'0000000-'$((2*$i))'9999999'
curl -# -f -r $((2*$i))'0000000'-$((2*$i))'9999999' -o ~/down/$fn$((2*$i)) $url &
curl -# -f -r $((2*$i+1))'0000000'-$((2*$i+1))'9999999' -o ~/down/$fn$((2*$i+1)) $url &
wait $(jobs -p)
done;
echo 'parts:'
ls ~/down/$fn?
ls ~/down/$fn??
echo Combining...
cat ~/down/$fn? >> ~/down/$fn
cat ~/down/$fn?? >> ~/down/$fn
echo 'SHASUM:'
shasum ~/down/$fn


function ctrl_c() {
        echo "** Trapped CTRL-C"
        kill $(jobs -p)
}

function size(){
	curl -I $url | grep -i Content-Length | awk '{print $2}'	#Used this function and wanted to send the result to a function to format the bytes to KB or MB, and it has a hidden carriage return, pipe the result to tr -d '\r' to remove them
	#curl -sI $URL | grep -i content-length to avoid case sensitive you have to use -i in grep 
	#http://stackoverflow.com/questions/4497759/how-to-get-remote-file-size-from-a-shell-script
	#another method
		#size=$(HEAD ${url})
		#size=${size##*Content-Length: }
		#size=${size%%[[:space:]]*}
}
