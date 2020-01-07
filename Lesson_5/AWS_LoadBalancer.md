# AWS ロードバランサー 建て方

参考サイト
- [ロードバランサーを使った負荷分散環境を構築](https://aws.amazon.com/jp/getting-started/projects/scalable-wordpress-website/03/)
- [Elastic Load Balancing（ロードバランサー）を作成](https://aws.amazon.com/jp/getting-started/projects/scalable-wordpress-website/03/03/)
- [ロードバランサーのはじめから](https://www.infraexpert.com/study/study24.html)

###### ↑圧倒的に分かりやすい｡

## EC2 構築

ここでの **PublicSubnet** と **PrivateSubnet** については､ただの名前が違うだけ｡

### PublicSubnet にて

- いつも通りの感じで **PublicSubnet** にインスタンスを1台建てる｡
- ログイン後に下記のコマンドを実行

```shell
$ sudo su -
# yum -y update
=> 更新
# amazon-linux-extras
=> 一覧を表示
# amazon-linux-extras | grep "nginx"
=> nginx だけを出力
# amazon-linux-extras install nginx1
=> nginx をインストール
# vim /usr/share/nginx/html/index.html
=> ドキュメントルートの index.html を自由に書き換える
# systemctl start nginx
=> nginx 起動
# systemctl enable nginx
=> nginx 自動起動
```

下記の様になっていればOK(画像を表示してるだけ｡)
![](https://i.imgur.com/jvMj9sI.jpg)


### PrivateSubnet にて

- 『PublicSubnet にて』 で建てたインスタンスを 【停止】 させる｡
	- 完全に停止するまで待機
	- ![](https://i.imgur.com/RWiwXjj.png)
- 停止したインスタンスを選択後に､ 【アクション】→【イメージ】→【イメージの作成】 を選択
	- ![](https://i.imgur.com/vlaxjuD.png)
- 『EC2 ダッシュボード』 → 【AMI】 を選択
	- ステータスが 『available』 まで待機
	- ![](https://i.imgur.com/VJd0RQd.png)
- 『EC2 ダッシュボード』 → 【インスタンス】 を選択
	- ![](https://i.imgur.com/zYOOqMm.png)
- 『マイ AMI』 から対象の起動後に下記の様になっていれば､起動まではOK
	- ![](https://i.imgur.com/HcjLtwU.png)

```shell
$ sudo su -
# vim /usr/share/nginx/html/index.html
=> 中身を分かりやすい様に書き換え
```

ここの時点でインスタンスが2台立ち上げってるはず｡

[![Image from Gyazo](https://i.gyazo.com/10d2ce32c9ea3c44619c56a849a1c25a.gif)](https://gyazo.com/10d2ce32c9ea3c44619c56a849a1c25a)

## ロードバランサーの作成手順

画像での手順書になります｡

- 『EC2 ダッシュボード』 → 『ロードバランサー』 → 【ロードバランサーの作成】 を選択
- 『Classic Load Balancer』 の 【作成】 を選択
	- ![](https://i.imgur.com/8cwzSLN.png)

### 手順1 : ロードバランサーの定義
- ロードバランサー名 : 任意の名前
- ロードバランサーを作成する場所 : 各自で作成したVPC
- サブネットの選択 : 『利用可能なサブネット』 からサブネットを選択
![](https://i.imgur.com/SzQ8J5e.png)

### 手順2 : セキュリティグループの割り当て

新規で作成も､既存のを使うのでもいい｡80番ポートが空いていればOK

![](https://i.imgur.com/LbZRiQb.png)

### 手順4 : ヘルスチェックの設定

- pingパス : / ← スラッシュのみ

![](https://i.imgur.com/ZkgCfAU.png)

### 手順5 : EC2 インスタンスの追加

- 『手順1 : ロードバランサーの定義』 で､選択したサブネットに建てた **インスタンス** があるはずなので､選択

![](https://i.imgur.com/n1AoZPV.png)

## 実際の動作シーン

[![Image from Gyazo](https://i.gyazo.com/ee9ecdc4fcfc59030db364305f0547a8.gif)](https://gyazo.com/ee9ecdc4fcfc59030db364305f0547a8)