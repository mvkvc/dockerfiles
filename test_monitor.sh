#!/bin/bash
threshold=10

count=0
while true
do

  gpu_load=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
  cpu_load=$(top -b -n2 -p 1 | fgrep "Cpu(s)" | tail -1 | awk -F'id,' -v prefix="$prefix" '{ split($1, vs, ","); v=vs[length(vs)]; sub("%", "", v); printf "%s%.0f\n", prefix, 100 - v }')
  if [[ $cpu_load -lt $threshold ]] && [[ $gpu_load -lt $threshold ]]
  then
    echo "Idle..."
    ((count+=1))
  else
    ((count==0))
  fi

  if (( count>15 ))
  then
    echo Shutting down
    # wait a little bit more before actually pulling the plug
    sleep 180
    poweroff
  fi

  sleep 3
done
