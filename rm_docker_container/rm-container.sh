#!/bin/bash

file=$1

cat $file | while read line
do
	containerId=${line:0:12};
	echo $containerId;
	docker rm $containerId
        echo 'has remove '${containerId}
        
done
