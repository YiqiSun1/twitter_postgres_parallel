#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
## FIXME: implement this with GNU parallel
time echo "$files" | parallel ./load_denormalized.sh
#    #use SQL's COPY command to load data into pg_denormalized
#
#
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
## FIXME: implement this with GNU parallel
time echo "$files" | parallel ./load_normalized.sh


echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel
time echo "$files" | parallel ./load_normalized_batch.sh




