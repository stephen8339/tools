#!/bin/sh
echo "$HOSTNAME" | sed "s/\([0-999]\)//g"| sed "s/\-\w\-.*//g" | sed "s/\w-//g" > hostname
SRV=$(cat hostname)
echo -e $SRV
cd /data/tools
./makemodify.sh
make stop-$SRV
if [ $? -eq 0 ]
                then
                        echo -e "\n== complete =="
                        break
                else
                        echo -e "\n== error =="
                        break
fi
rm -f hostname
