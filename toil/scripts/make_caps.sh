#!/usr/bin/env sh

# Make the directory name
dirname=shout_$1_$2
mkdir $dirname
shift
shift

# Start shouting
for var in "$@"
do
    filename=`echo $var | sed "s/.*\///"`
    cat $var | awk '{print toupper($0)}' > $dirname/shout_$filename
done

# Zip it
tar -zcf $dirname.tar.gz $dirname/
