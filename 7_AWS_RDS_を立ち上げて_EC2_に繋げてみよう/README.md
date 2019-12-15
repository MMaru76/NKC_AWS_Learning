###### tags: AWS, NKC

# AWS RDS を立ち上げて EC2 に繋げてみよう

:::danger
**今回の章が終わったら､必ずRDSサーバーを確実に消しましょう｡
RDSは停止していても料金がかかる模様｡**
:::

最初に AWS RDSを作成して実際に接続しますが､クレジット消費が激しいので､なるべく早めに消しましょう｡
以後は､PublicInstanceにインストールをするか､PrivateInstanceを作成してインストールかしてください｡

PrivateInstanceにMysqlサーバーをインストールする際は､踏み台からアクセスするようしましょう｡

## 余談

:question: また､これどういう意味なのかな?と疑問に思ったら､随時ググってみたり隣の人と相談してみましょう｡

[![Image from Gyazo](https://i.gyazo.com/87f635af9080efe76a002331fafd1907.png)](https://speakerdeck.com/takashi_toyosaki/awsnichao-xiang-siienziniaga-yu-tuhuan-jing-wotukurufang-fa?slide=53)

> 引用元: [AWSに超詳しいエンジニアが育つ環境をつくる方法](https://speakerdeck.com/takashi_toyosaki/awsnichao-xiang-siienziniaga-yu-tuhuan-jing-wotukurufang-fa?slide=53)
> [オススメ記事](https://dev.classmethod.jp/cloud/aws/moko-aws-6kan/) ←是非オススメ!何がオススメなの?見てみよう｡

:::warning
抜けてる部分や足りない部分があるかもしれません｡その時は調べてみよう｡
:::

## 1. 【RDS】 とは?

:::info

>Amazon RDSとは、米国Amazon.comが発表した、クラウドコンピューティング環境でリレーショナルデータベースを構築・運用できるサービスである。

>Amazon RDSはMySQL（MySQL 5.1）をベースとしたリレーショナルデータベースであり、クラウドサービス「Amazon Web Services」においてオプションとして利用できる。MySQLの全機能がAmazon RDSでも利用可能となっており、既存のMySQL向けのツールやアプリケーションが容易にAmazon RDSへ適用できるというメリットがある。また、データベース本体のアップデートやデータのバックアップ管理などはAmazon RDS側で管理されるため、メンテナンスのコストも軽減される。

>Amazon Web Servicesでは、既に「Amazon SimpleDB」と呼ばれるデータベースを提供している。両者の違いとしては、Amazon SimpleDBが比較的簡易なデータベースを提供するのに対して、Amazon RDSはより高度で複雑なリレーショナルデータベースを提供するものである。

:::

引用元 : [Amazon RDSとは何？ Weblio辞書](https://www.weblio.jp/content/Amazon+RDS)

## 2. 【RDS】 サービス画面へ移動

【サービス】→検索窓にて ｢rds｣ と入力→ヒットしたのを選択

[![Image from Gyazo](https://i.gyazo.com/cdcf7b6da2809bf7a5e735a7e0826c45.png)](https://gyazo.com/cdcf7b6da2809bf7a5e735a7e0826c45)

---

:::success
Hello 『Amazon Relational Database Service(Amazon RDS)』 World Dashboard :tada:
:::

[![Image from Gyazo](https://i.gyazo.com/eab70afadb42f5b8bdc2f3328fb3a5d8.png)](https://gyazo.com/eab70afadb42f5b8bdc2f3328fb3a5d8)

---
---

## 3. 【RDS】 サブネットグループ 作成

【ダッシュボード】→【サブネットグループ】 を選択→【DB サブネットグループの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/eea98bc36871a5bd0150618e53611ea7.png)](https://gyazo.com/eea98bc36871a5bd0150618e53611ea7)

---

### 3-1) 【サブネットグループの詳細】


| 項目 | 値 | 説明 |
| :--: | :--: | :--: |
| 名前 | 任意 | ローマ字 |
| 説明 | 任意 | ローマ字 |
| VPC | [個人で作成したVPC](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/By6frCSwH) |  |

[![Image from Gyazo](https://i.gyazo.com/edb08e571ebc0eb76941fbe32ce143ce.png)](https://gyazo.com/edb08e571ebc0eb76941fbe32ce143ce)

---

### 3-2) 【サブネットの追加】 GIF動画付き

【この VPC に関連するすべてのサブネットを追加します】 を選択

[![Image from Gyazo](https://i.gyazo.com/8d90984f85f019e439a761b0aa7b1fa3.gif)](https://gyazo.com/8d90984f85f019e439a761b0aa7b1fa3)

完成形↓

[![Image from Gyazo](https://i.gyazo.com/6e9a62411e4f5a48c885460786b79645.png)](https://gyazo.com/6e9a62411e4f5a48c885460786b79645)

---

思ってる疑問は↓の詳細に載ってるかも?

:::spoiler

本当に自分が作成したVPC内のサブネットを使用してるの?って思う人は､【VPC】から【サブネット】を選択して目grepしてみよう!

[![Image from Gyazo](https://i.gyazo.com/fc819cd0a760a9f74c21f6092c33aa3a.png)](https://gyazo.com/fc819cd0a760a9f74c21f6092c33aa3a)

:::

---

### 3-3) 【DB サブネットグループの作成】 完成

ステータスが完了になっていれば､基本的に問題ないけど稀に失敗する事があるため･･その際は作り直し｡(サービスは絶対では無い｡)

[![Image from Gyazo](https://i.gyazo.com/54424178be03732a658b249e72bd220c.png)](https://gyazo.com/54424178be03732a658b249e72bd220c)

---
---

## 4. 【RDS】 パラメーターグループ 作成

【ダッシュボード】→【パラメーターグループ】 を選択→【パラメーターグループの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/095005aca23085e89f0439b6820c3e7d.png)](https://gyazo.com/095005aca23085e89f0439b6820c3e7d)

---

### 4-1) 【パラメーターグループの詳細】

| 項目 | 値 | 説明 |
| :--: | :--: | :--: |
| パラメーターグループファミリー | mysql5.7 |  |
| グループ名 | 任意 |  |
| 説明 | 任意 |  |

[![Image from Gyazo](https://i.gyazo.com/97858a7e593bba6b72bba794bb976a2c.png)](https://gyazo.com/97858a7e593bba6b72bba794bb976a2c)

---

### 4-2) 【パラメーターグループの作成】 完成

[![Image from Gyazo](https://i.gyazo.com/688a28d21b00d3ade27ace38ce37d26c.png)](https://gyazo.com/688a28d21b00d3ade27ace38ce37d26c)

---
---

## 5. 【RDS】 データベース 作成

【ダッシュボード】→【データベース】 を選択→【データベースの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/3b336e6fa2953f9e08ec4dee74fbeb1b.png)](https://gyazo.com/3b336e6fa2953f9e08ec4dee74fbeb1b)

---

### 5-1) 【データベース作成方法を選択】

今回は自分で各種項目を選んでデータベースを作成する為､【標準設定】 を選択

[![Image from Gyazo](https://i.gyazo.com/4bb762f5c8452216d18fa55b8bdd7505.png)](https://gyazo.com/4bb762f5c8452216d18fa55b8bdd7505)

---

### 5-2) 【エンジンのオプション】

様々なデータベースエンジンの種類があって､AWS が独自に提供している [Aurora](https://aws.amazon.com/jp/rds/aurora/) からお金が高いOracleまでありますが､今回は 【MySQL】 を使います｡

バージョンは､個人の好きな物を選択｡

[![Image from Gyazo](https://i.gyazo.com/557fe219b46363d1928e2548f508dbba.png)](https://gyazo.com/557fe219b46363d1928e2548f508dbba)

---

### 5-3) 【テンプレート】

(学生版の画面がどの様になっているか確認出来ない為､本番環境以外を選択)
テストで起動してみたい方や､無料枠を利用している方などは､【無料利用枠】 を選択

[![Image from Gyazo](https://i.gyazo.com/15ba75a8544f26954dc5da3648fe5741.png)](https://gyazo.com/15ba75a8544f26954dc5da3648fe5741)

---

### 5-4) 【設定】

| 項目 | 値 | 説明 |
| :--: | :--: | :--: |
| DB インスタンス識別子 | 一意 | 世界で被ってはダメ |
| マスターユーザー名 | 任意 | 忘れない為に ｢admin｣ |
| マスターパスワード | 任意 | 絶対に忘れるから ｢!qwertyuiop!｣ |

[![Image from Gyazo](https://i.gyazo.com/165209d7dcc6d741860790ef04c8c3b0.png)](https://gyazo.com/165209d7dcc6d741860790ef04c8c3b0)

---

### 5-5) 【接続】

| 項目 | 値 | 説明 |
| :--: | :--: | :--: |
| VPC| [個人で作成したVPC](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/By6frCSwH) |  |

[![Image from Gyazo](https://i.gyazo.com/86eaa6be3af885319f434946e1bc7d8e.png)](https://gyazo.com/86eaa6be3af885319f434946e1bc7d8e)

---

#### 5-5-1) 【接続-追加の接続設定】

| 項目 | 値 | 説明 |
| :--: | :--: | :--: |
| サブネットグループ | [3. 【RDS】 サブネットグループ 作成](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/rJnAFzKpS#3-%E3%80%90RDS%E3%80%91-%E3%82%B5%E3%83%96%E3%83%8D%E3%83%83%E3%83%88%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97-%E4%BD%9C%E6%88%90) |  |
| パブリックアクセス可能 | なし | インターネットに出る必要が無い為 |
| VPC SG名| 新規作成 |  |
| 新しい VPC SG名 | 任意 |  |
| AZ | us-east-1b | [作成したVPCのPrivateサブネット](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/By6frCSwH#%E5%95%8F%E9%A1%8C) |
| データベースポート | 3306 |  |

[![Image from Gyazo](https://i.gyazo.com/cee547292fce8f1220e4cf0f3df3474b.png)](https://gyazo.com/cee547292fce8f1220e4cf0f3df3474b)

---

### 5-6) 【データベース認証】

【パスワード認証】 を選択

[![Image from Gyazo](https://i.gyazo.com/9f2fa2330e4daa56fc0d80de51b60fde.png)](https://gyazo.com/9f2fa2330e4daa56fc0d80de51b60fde)

【データベースの作成】 を選択

### 5-7) 【データベースの作成】 完了

完了する為に5~10分前後掛かるため､その間にEC2の方をセットアップをする｡

[![Image from Gyazo](https://i.gyazo.com/6a9dc4de03dab12e6161dd2dd3ade41c.png)](https://gyazo.com/6a9dc4de03dab12e6161dd2dd3ade41c)

---
---

## 6. 【RDS&RC2】 EC2 から RDS へ 接続

『[AWS ネットワーク環境の構築手順](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/By6frCSwH)』 や 『[追加課題の解答 踏み台 20191203](https://hackmd.io/Pgk7EfGbS5KzNOWtUlN0Gg)』 を参考に､パブリックサブネットにインスタンスを作成しましょう｡

また､作成したインスタンスへの接続方法は自由です｡
==(接続方法がワカランという方はGoogleドキュメントを見て)==

:::info
下記の ｢=>｣ 以降については､出力結果です｡
```
=> TEST ←については､出力結果です｡
```

:::


>インスタンスに接続すると下記のように表示されるはず｡
[![Image from Gyazo](https://i.gyazo.com/75dbce77081d35f8e10f2ca31f09f80c.png)](https://gyazo.com/75dbce77081d35f8e10f2ca31f09f80c)

---

### 6-1) 【SG の設定変更】

1. 『[5. セキュリティグループ の作成手順](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/By6frCSwH#5-%E3%82%BB%E3%82%AD%E3%83%A5%E3%83%AA%E3%83%86%E3%82%A3%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97-%E3%81%AE%E4%BD%9C%E6%88%90%E6%89%8B%E9%A0%86)』 で作成した SG の 【グループ ID】 をコピー
2. 『[5-5-1) 【接続-追加の接続設定】 の 【新しい VPC SG名】](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/rJnAFzKpS#5-5-1-%E3%80%90%E6%8E%A5%E7%B6%9A-%E8%BF%BD%E5%8A%A0%E3%81%AE%E6%8E%A5%E7%B6%9A%E8%A8%AD%E5%AE%9A%E3%80%91)』 を選択
	- 【インバウンド】→【編集】 を選択
	- 【ソース】 の IP 部分を削除
	- 上記でコピーしたのをペースト
3. 【保存】 を選択

おそらく､ソースに部分に書かれてるIPは学校のグローバルIPなはず､[グローバルIPの確認方法](https://www.cman.jp/network/support/go_access.cgi)｡

:::info
なんで､SGのソース部分を変更までして面倒くさい事をするのか疑問な人は､ソース部分を一旦学校のグローバルIPのままにしたり､適当にプライベートサブネットのCIDRブロックを指定したりして試して楽しんでみてください｡
:::

[![Image from Gyazo](https://i.gyazo.com/66f410cf0665ab3cbf6cd1e6b921e685.gif)](https://gyazo.com/66f410cf0665ab3cbf6cd1e6b921e685)

:::spoiler

疑問に思うことはとても大事です｡
ただ本番環境などでは､疑問に思うことは時間の無駄です｡
先に自分で色々な失敗をしましょう｡
せっかくAWSを無料で使えるので使い倒しましょう｡

:::

### 6-2) 【必要なパッケージのインストール】

- インストール方法

```bash
[ec2-user@パブリックIP ~]$ sudo yum -y install mysql57
```

- バージョン確認方法(多少違うかもしれない)

```bash
[ec2-user@パブリックIP ~]$ mysql -V

=> mysql  Ver 14.14 Distrib 5.7.27, for Linux (x86_64) using  EditLine wrapper
```

### 6-3) 【RDS へ接続】

1. 『[5-7) 【データベースの作成】 完了](https://hackmd.io/@JWGkc17TT-Cdw7vZF9raow/rJnAFzKpS#5-7-%E3%80%90%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%81%AE%E4%BD%9C%E6%88%90%E3%80%91-%E5%AE%8C%E4%BA%86)』 で作成したデータベースを選択
2. 【接続とセキュリティ項目】→【エンドポイント】 をコピー

[![Image from Gyazo](https://i.gyazo.com/6a60a84a455050b6129d5b67b597e3c2.png)](https://gyazo.com/6a60a84a455050b6129d5b67b597e3c2)

---

作成したデータベースへ接続するコマンドについて

- -h
	- 接続する先のホスト名
- -u
	- ユーザー名
- -p
	- パスワード

接続をする際に､対話型でパスワードを聞かれるのでパスワードを入力

```bash
[ec2-user@パブリックIP ~]$ mysql -h エンドポイント名 -u admin -p
```

実際に接続した際のスクリーンショット

[![Image from Gyazo](https://i.gyazo.com/c9b9ed4bb1de3be38b228bc7bd18920f.png)](https://gyazo.com/c9b9ed4bb1de3be38b228bc7bd18920f)

適当になにかを入力してみよう｡

[![Image from Gyazo](https://i.gyazo.com/f8373d389e8156f5a42719d3306b915e.png)](https://gyazo.com/f8373d389e8156f5a42719d3306b915e)

## 7. 【RDS】 データベース 削除

高いので削除します｡削除に時間が掛かる為､その間は別の事をしましょう｡

1. 【アクション】 から 【削除】 を選択

>[![Image from Gyazo](https://i.gyazo.com/4e497612c442aa9d95b6016e8c1f5644.png)](https://gyazo.com/4e497612c442aa9d95b6016e8c1f5644)

2. 下記の画像の様にして 『delete me』 と入力して 【削除】 を選択

>[![Image from Gyazo](https://i.gyazo.com/12749d7d117e2568af521d0a0989c34c.png)](https://gyazo.com/12749d7d117e2568af521d0a0989c34c)

3. しばらく待つと削除される｡

> [![Image from Gyazo](https://i.gyazo.com/109dfc3e21532e8c633dca18a1b5e5e3.png)](https://gyazo.com/109dfc3e21532e8c633dca18a1b5e5e3)

## 8. 【EC2】 MySQL サーバー 構築&接続

:::warning

こちらの章は自由です｡
AWSとは全く関係無いです｡

:::

同じインスタンスに対してMySQLサーバーを構築する方法

### 8-1) MySQLサーバーのインストール

```bash
[ec2-user@パブリックIP ~]$ sudo yum -y install mysql57-server
=> ~~省略~~
```

#### 8-2) 起動してるか確認

```bash
[ec2-user@パブリックIP ~]$ sudo service mysqld status

=> mysqld is stopped
```

#### 8-3) 起動方法

```bash
[ec2-user@パブリックIP ~]$ sudo service mysqld start

=> Initializing MySQL database
~~省略~~
Starting mysqld:                                           [  OK  ]
```

#### 8-4) 初期設定方法

==パスワードの部分以外は､エンターキーを押してスキップ==

```bash
[ec2-user@パブリックIP ~]$ $ mysql_secure_installation

# 現在のMySQLのrootパスワードを入力。
New password:

# パスワードの再入力
Re-enter new password:

# 匿名ユーザーを削除するか？不要なのでYで削除
Remove anonymous users? [Y/n]

# rootユーザーのリモートホストからのログインを無効化するか?無効化したいのでY
Disallow root login remotely? [Y/n]

# 初期状態ではtestデータベースがあるが削除するか?削除したいのでY
Remove test database and access to it? [Y/n]

# 変更を即座に反映するために特権テーブルの読み込みを行うか?反映させたいのでY
Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n]


# 終わり
All done!  If you've completed all of the above steps, your MySQL
installation should now be secure.

Thanks for using MySQL!


Cleaning up...
```

#### 8-5) MySQLサーバーへ接続

```bash
[ec2-user@パブリックIP ~]$ mysql -u root -p
=> Enter password: パスワードを入力
```

---
---

# アンケート

:::info
アンケートの回答自体は任意です｡
また名前の記載は任意です｡
:::

改善点や要望そして､相談などがあれば気軽にフォームに送って頂いて構いません｡

[回答フォーム](https://forms.gle/arfE9ndzwc86YYVp8)

こちらの章について､追加課題はありませんが､これでMySQLサーバーの構築が出来たかと思います｡
あとは､個人で各種データベース作ってテーブル項目を考えてデータを突っ込んでみてもも楽しいかもしれません｡

>:+1: 例えば､データーベース授業で使っているデータを実際に流し込んでみて､それをWebサイトで取得出来るようにするなど｡

---

次回は､Amazon CloudFront(CDN)やS3とかを紹介する予定です｡(変わるかもしれないです｡)
Route53当たりとかも紹介出来たら!と思っています｡(こちらは僕のドメインを使うかもしれない｡)