# Bash（シェルスクリプト）のみで ナップサック問題を解くチャレンジプロジェクト

# 問題：

#### 容量65のナップサックに以下の表にある品物を詰め込むとする。この時、詰め込んだ品物の総価値を最大にするためには何をいくつ詰め込むといいか。
※同じ品物を何個詰め込んでもいいものとする。

| 品物              | 一個当たりの価値 | 一個当たりのサイズ |
|-------------------|------------------|---------------------|
| 缶コーヒー         | 120              | 10                  |
| 水入りペットボトル | 130              | 12                  |
| バナナ             | 80               | 7                   |
| りんご             | 100              | 9                   |
| おにぎり           | 250              | 21                  |
| パン               | 185              | 16                  |

### 実行方法
```
# スクリプトに実行権限を与える
chmod +x knapsack.sh
```
### 実行する
```
./knapsack.sh
```