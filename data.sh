#!/bin/bash

export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

declare -i capacity=65

declare -a names=("缶コーヒー" "水入りペットボトル" "バナナ" "りんご" "おにぎり" "パン")
declare -a values=(120 130 80 100 250 185)
declare -a weights=(10 12 7 9 21 16)

declare -i item_count=${#values[@]}

#echo "capacity: $capacity"
#echo "names: ${names[@]}"
#echo "values: ${values[@]}"
#echo "weights: ${weights[@]}"
#echo "item_count: $item_count"


#name="缶コーヒー"
#size="大"
#echo "${name} サイズ: ${size}"
