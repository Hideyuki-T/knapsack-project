#!/bin/bash

source ./data.sh

# 配列宣言
declare -a dp

# DPテーブル初期化
for ((w=0; w<=capacity; w++)); do
  dp[$w]=0
done

# 動的計画法で最大価値計算
for ((i=0; i<item_count; i++)); do
  for ((w=capacity; w>=weights[i]; w--)); do
    candidate=$(( dp[w - weights[i]] + values[i] ))
    if (( candidate > dp[w] )); then
      dp[$w]=$candidate
    fi
  done
done

# 最大価値の出力
echo "最大価値: ${dp[$capacity]}"

# --- 選ばれた品物の逆トレース ---
current_weight=$capacity
selected_items=()

for ((i=item_count-1; i>=0; i--)); do
  if (( current_weight >= weights[i] )); then
    prev_weight=$(( current_weight - weights[i] ))
    if (( dp[current_weight] == dp[prev_weight] + values[i] )); then
      selected_items+=($i)
      current_weight=$prev_weight
    fi
  fi
done

echo ""
echo "選ばれた品物一覧："
total_value=0
total_weight=0

for idx in "${selected_items[@]}"; do
  name=${names[$idx]}
  value=${values[$idx]}
  weight=${weights[$idx]}
  echo "- $name（価値: $value サイズ: $weight）"
  ((total_value += value))
  ((total_weight += weight))
done

echo ""
echo "合計サイズ: $total_weight"
echo "合計価値: $total_value"
