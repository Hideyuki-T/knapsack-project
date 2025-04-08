#!/bin/bash

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

source ./data.sh

# dp は各重さに対応する最大価値
# sel は各重さに対応する、選択した品物のインデックス（スペース区切りの文字列）を記録
declare -a dp
declare -a sel

# 初期化：重さ 0 から capacity まで
for ((w=0; w<=capacity; w++)); do
  dp[$w]=0
  sel[$w]=""  # 空文字
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

# 選択情報は sel[capacity] に記録されている（スペース区切りのインデックス）
selected_items=(${sel[capacity]})

# 選択された品物リストの表示：できれば本来の順番にするため、逆順に出す（後ろで追加されているため）
reversed=()
for (( idx=${#selected_items[@]}-1; idx>=0; idx-- )); do
  reversed+=( "${selected_items[idx]}" )
done

echo ""
echo "選ばれた品物一覧："
total_value=0
total_weight=0
for idx in "${reversed[@]}"; do
  name=${names[idx]}
  value=${values[idx]}
  weight=${weights[idx]}
  echo "- $name（価値: $value サイズ: $weight）"
  ((total_value += value))
  ((total_weight += weight))
done

echo ""
echo "合計サイズ: $total_weight"
echo "合計価値: $total_value"
