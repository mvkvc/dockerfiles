#!/bin/bash
threshold=10

count=0
while true
do

  load=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  #load=$(uptime | sed -e 's/.*load average: //g' | awk '{ print $3 }')
  res=$(echo $load'<'$threshold | bc -l)
  if (( $res ))
  then
    echo "Idle..."
    ((count+=1))
  fi
  echo "Idle minutes count = $count"

  if (( count>30 ))
  then
    echo Shutting down
    # wait a little bit more before actually pulling the plug
    sleep 300
    sudo poweroff
  fi

  sleep 60

done
