#!/bin/bash
#s

files=$(find data/*)
echo '================================================================================'
echo 'load denormalized'
echo '================================================================================'
time for file in $files; do
    echo
    unzip -p "$file" | sed 's/\\u0000//g' | psql postgres://postgres:pass@localhost:11644/postgres -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"
    # copy your solution to the twitter_postgres assignment here
done
files=$(find data/*)
echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
time for file in $files; do
     echo
     python3 load_tweets.py --db postgresql://postgres:pass@localhost:10645/postgres --inputs "$file" --print_every 10000
    # copy your solution to the twitter_postgres assignment here
done
files=$(find data/*)
echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
time for file in $files; do
    python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:10646/ --inputs $file
done
