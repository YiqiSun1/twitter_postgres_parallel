#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
for file in $files; do
     unzip -p "$file" | sed 's/\\u0000//g' | psql postgres://postgres:pass@localhost:10064/postgres -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
    #use SQL's COPY command to load data into pg_denormalized
done

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
# FIXME: implement this with GNU parallel
for file in $files; do
        python3 load_tweets.py --db postgresql://postgres:pass@localhost:11064/postgres --inputs "$file" --print_every 10000
done



echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
# FIXME: implement this with GNU parallel




