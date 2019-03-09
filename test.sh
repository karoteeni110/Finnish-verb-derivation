#!/bin/bash

cat testwordlist.txt | hfst-lookup FSN.hfst | awk '{print $2}' 1>outcome.txt
cat outcome.txt | hfst-lookup finntreebank.hfst 1>test_result.txt
correct=$(cat test_result.txt | grep -F '<V><act><a><sg>' | wc -l )
all=$(cat outcome.txt | wc -l )
printf "\nPrecision:\n"
echo "scale=2 ; $correct / $all" | bc