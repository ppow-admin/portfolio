#!/bin/bash
#
#Script I used to generate files for various testing scenarios
#
#

echo $PWD
cd /home/seth/Scripts
echo "Creating 1000 files for you..."
for i  in {1..1000}
do
   FILE="$RANDOM.txt"
#   echo $FILE # show file name
   > $FILE # create files;
done

ls -la /home/seth/Scripts
