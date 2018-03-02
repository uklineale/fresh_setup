#!/bin/bash
dependencies_file=$1

while read -r dependency
do
		sudo apt install $dependency -y
done <	"${dependencies_file}"
