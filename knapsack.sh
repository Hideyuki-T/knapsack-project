#!/bin/bash

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

source ./data.sh

# dp は各重さに対応する最大価値
declare -a dp
declare -a sel

for ((w=0; w<=capacity; w++)); do
  dp[$w]=0
  sel[$w]=""
done

# DP の計算と同時に、選択情報も更新する
for ((i=0; i<item_count; i++)); do
  for ((w=capacity; w>=weights[i]; w--)); do
    candidate=$(( dp[w - weights[i]] + values[i] ))
    if (( candidate > dp[w] )); then
      dp[w]=$candidate
      if [ -z "${sel[w - weights[i]]}" ]; then
        sel[w]="$i"
      else
        sel[w]="${sel[w - weights[i]]} $i"
      fi
    fi
  done
done

echo "最大価値: ${dp[capacity]}"

#echo "sel[capacity]: [${sel[capacity]}]"
IFS=' ' read -r -a selected_items <<< "${sel[capacity]}"
#echo "selected_items: ${selected_items[@]}"


reversed=()
for (( idx=${#selected_items[@]}-1; idx>=0; idx-- )); do
  reversed+=( "${selected_items[idx]}" )
done

echo ""
echo "選ばれた品物一覧："
total_value=0
total_weight=0
for idx in "${reversed[@]}"; do
  name=${names[$idx]}
  value=${values[$idx]}
  weight=${weights[$idx]}
  printf -- "- %s（価値: %d サイズ: %d）\n" "$name" "$value" "$weight"
  ((total_value += value))
  ((total_weight += weight))
done


echo ""
echo "合計サイズ: $total_weight"
echo "合計価値: $total_value"


#echo "capacity: $capacity"
#echo "names: ${names[@]}"
#echo "values: ${values[@]}"
#echo "weights: ${weights[@]}"
#echo "item_count: $item_count"
