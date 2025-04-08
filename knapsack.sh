#!/bin/bash

source ./data.sh

for ((w=0; w<=capacity; w++)); do
  dp[$w]=0
done

for ((i=0; i<item_count; i++)); do
  for ((w=capacity; w>=weights[i]; w--)); do
    candidate=$(( dp[w - weights[i]] + values[i] ))
    if (( candidate > dp[w] )); then
      dp[$w]=$candidate
    fi
  done
done

echo "最大価値: ${dp[$capacity]}"
