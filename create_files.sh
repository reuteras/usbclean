#!/bin/bash

set -e

TEXT="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec a diam lectus. Sed sit amet ipsum mauris. Maecenas congue ligula ac quam viverra nec consectetur ante hendrerit. Donec et mollis dolor. Praesent et diam eget libero egestas mattis sit amet vitae augue. Nam tincidunt congue enim, ut porta lorem lacinia consectetur. Donec ut libero sed arcu vehicula ultricies a non tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ut gravida lorem."

for ((j = 0; j < 5000; j++)); do
    # shellcheck disable=SC1117
    # shellcheck disable=SC2028
    echo "Secret file $j in root. \n$TEXT" > secret_file_"$j".txt
done

i=0
while true; do
    mkdir dir"$i"
    for ((j = 0; j < 5000; j++)); do
        # shellcheck disable=SC1117
        # shellcheck disable=SC2028
        echo "Secret file $j in dir $i. \n$TEXT" > dir"$i"/secret_file_"$j".txt
    done
    i=$((i + 1))
done
