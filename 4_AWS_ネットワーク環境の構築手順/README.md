###### tags: AWS, NKC

# AWS ネットワーク環境の構築手順

今回の目標は､左の空っぽ状態から右のような VPC 環境を作ります｡

:::warning

[![Image from Gyazo](https://i.gyazo.com/ef3d465395aba6f2ee1abd3e867b4e08.png)](https://gyazo.com/ef3d465395aba6f2ee1abd3e867b4e08)

:::

## 各配色について

[![Image from Gyazo](https://i.gyazo.com/ed9de605dc5a5668ac011245a5845612.png)](https://gyazo.com/ed9de605dc5a5668ac011245a5845612)

## 0. AWS コンソールから VPC へのアクセス手順

[![Image from Gyazo](https://i.gyazo.com/0ba9513ac0aa0675c38f38c3695d78f2.png)](https://gyazo.com/0ba9513ac0aa0675c38f38c3695d78f2)

## 1. Virtual Private Cloud の作成手順

:::info
Virtual Private Cloud(以降､VPC)
:::

-  イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/47fbfdc6197241776ef2f31ff96f6e9d.png)](https://gyazo.com/47fbfdc6197241776ef2f31ff96f6e9d)

--- 

- VPC ダッシュボードから 【VPC】 を選択
- 【VPCの作成】 を選択
[![Image from Gyazo](https://i.gyazo.com/47db345db53679f1b23d1e2018d58aa7.png)](https://gyazo.com/47db345db53679f1b23d1e2018d58aa7)

---

- 【名前タグ】 に任意の名前を入力
- 【IPv4 CIDR ブロック】 に 『10.0.0.0/16』 と入力

[![Image from Gyazo](https://i.gyazo.com/acab6cec031fb33f146c0907639119d1.png)](https://gyazo.com/acab6cec031fb33f146c0907639119d1)

---

- 下記のような画面が表示されたら 【閉じる】 を選択

[![Image from Gyazo](https://i.gyazo.com/81ccc7f9dd5c475acb0182b450ac6da2.png)](https://gyazo.com/81ccc7f9dd5c475acb0182b450ac6da2)

---

- ==確認項目== 対象の VPC の 【説明】 で下記項目を確認
	- [ ] 状態 : available
	- [ ] IPv4 CIDR : 10.0.0.0/16

[![Image from Gyazo](https://i.gyazo.com/3922a4745c13ee0b1fd9d98252df0ccc.png)](https://gyazo.com/3922a4745c13ee0b1fd9d98252df0ccc)

## 2. サブネットの作成手順

-  イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/d5a9bab734132ed5879f3f00310cf4d1.png)](https://gyazo.com/d5a9bab734132ed5879f3f00310cf4d1)

---

- VPC ダッシュボードから 【サブネット】 を選択
- 【サブネットの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/d5050f40b7cc98e57b53ee43155f58c3.png)](https://gyazo.com/d5050f40b7cc98e57b53ee43155f58c3)

---

- 【名前タグ】 に任意の名前を入力
	- 用途に合った最適な名前タグを命名
	- 今回の目的はパブリック向けのサブネットの作成
- 【VPC】 に 『1. VPCの作成手順』 で作成した VPC を選択
- 【アベイラビリティーゾーン】 に 『us-east-1a』 を選択
- 【IPv4 CIDR ブロック】 に 『10.0.1.0/24』 と入力

[![Image from Gyazo](https://i.gyazo.com/c4ac99a970f48f91bfcba54459245d41.png)](https://gyazo.com/c4ac99a970f48f91bfcba54459245d41)

---

- 下記のような画面が表示されたら 【閉じる】 を選択

[![Image from Gyazo](https://i.gyazo.com/e1ead293956eeec3e28163673e7acfb4.png)](https://gyazo.com/e1ead293956eeec3e28163673e7acfb4)

---

- ==確認項目== 対象のサブネットの 【説明】 で下記項目を確認
	- [ ] VPC : 『1. VPCの作成手順』 の名前
	- [ ] アベイラビリティゾーン : us-east-1a(use1-az4)
	- [ ] 状態 : available
	- [ ] IPv4 CIDR : 10.0.1.0/24

[![Image from Gyazo](https://i.gyazo.com/b71229cb865a43d9d43e55cee7e79452.png)](https://gyazo.com/b71229cb865a43d9d43e55cee7e79452)

---

### 問題

:::info
【1.VPCの作成手順】 で作成したVPCを使用し､下記の条件を満たすサブネットを作成せよ｡
- ==条件==
	- [ ] プライベート環境用のサブネット
	- [ ] アベイラビリティゾーン : us-east-1b(use1-az6)
	- [ ] 状態 : available
	- [ ] IPv4 CIDR : 10.0.2.0/24

- 完成条件

	[![Image from Gyazo](https://i.gyazo.com/3beaa1eb1c0ac559cd38837325d1b419.png)](https://gyazo.com/3beaa1eb1c0ac559cd38837325d1b419)
:::

---

## 3. インターネットゲートウェイ の作成手順

:::info
インターネットゲートウェイ(以降､IGW)
:::

-  イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/ab5fd06dbd145e76801af886c7d7f67e.png)](https://gyazo.com/ab5fd06dbd145e76801af886c7d7f67e)

---

- VPCダッシュボードから 【インターネットゲートウェイ(以下IGW)】 を選択
- 【IGWの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/6b2bbaff9a0516917bb058aa298ca66a.png)](https://gyazo.com/6b2bbaff9a0516917bb058aa298ca66a)

---

- 【名前タグ】 に任意の名前を入力
	- 用途に合った最適な名前タグを命名

[![Image from Gyazo](https://i.gyazo.com/424c3067e855fcafc6f7851624759def.png)](https://gyazo.com/424c3067e855fcafc6f7851624759def)

---

- 下記のような画面が表示されたら 【閉じる】 を選択

[![Image from Gyazo](https://i.gyazo.com/d7142c2a75a5f779acc1b04966bc00e5.png)](https://gyazo.com/d7142c2a75a5f779acc1b04966bc00e5)

---

- ==確認項目== 対象の IGW の 【説明】 で下記項目を確認
	- [ ] 状態 : detached
	- [ ] アタッチ済み VPC ID : - 

[![Image from Gyazo](https://i.gyazo.com/e6cf811e9e0abbd155f1bd2c928d2fb8.png)](https://gyazo.com/e6cf811e9e0abbd155f1bd2c928d2fb8)

---

- 対象の IGW を選択
- 【アクション】 から 【VPCにアタッチ】 を選択

[![Image from Gyazo](https://i.gyazo.com/f61bfb7817cee02114f3edc18e943866.png)](https://gyazo.com/f61bfb7817cee02114f3edc18e943866)

---

- 【VPC】 に 『1.VPCの作成手順』 で作成した VPC を選択

[![Image from Gyazo](https://i.gyazo.com/9d34a06042266f0c955e9eeb209e86e5.png)](https://gyazo.com/9d34a06042266f0c955e9eeb209e86e5)

---

- ==確認項目== 対象の IGW の 【説明】 で下記項目を確認
	- [ ] 状態 : attached
	- [ ] アタッチ済み VPC ID : 『1.VPCの作成手順』

[![Image from Gyazo](https://i.gyazo.com/350e9bdf8ca889e2bdcca03177ec661d.png)](https://gyazo.com/350e9bdf8ca889e2bdcca03177ec661d)

## 4. ルートテーブルの作成手順

-  イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/6126a3a0c3d1b2f447bba26d65fa7847.png)](https://gyazo.com/6126a3a0c3d1b2f447bba26d65fa7847)

---

- VPCダッシュボードから 【ルートテーブル】 を選択
- 対象のルートテーブルを選択後に 【ルート】 タブを選択
- 【ルートの編集】 を選択

[![Image from Gyazo](https://i.gyazo.com/27cf9f03b892fab4109337c28254d7be.png)](https://gyazo.com/27cf9f03b892fab4109337c28254d7be)

---

現在はVPC内宛の通信のルートしか登録されていない為､IGW宛の通信を登録

- 送信先 : 0.0.0.0/0
- ターゲット : 『3. IGWの作成手順』 で作成した IGW を選択

[![Image from Gyazo](https://i.gyazo.com/dae9bac07aaed16e81e2dbffaae707cc.png)](https://gyazo.com/dae9bac07aaed16e81e2dbffaae707cc)

---

- ==確認項目== 対象の ルートテーブル の 【ルート】 で下記項目を確認
	- [ ] 送信先 : 0.0.0.0/0
	- [ ] ターゲット : 『3. IGWの作成手順』

[![Image from Gyazo](https://i.gyazo.com/9df203e1d2016351547325333e1993c4.png)](https://gyazo.com/9df203e1d2016351547325333e1993c4)

---

この時点ではルートテーブルは､対象の VPC と関連付けされたが､サブネットとは関連付けされていないので関連付けの作業をおこなう

- 対象のルートテーブルを選択
- 【サブネットの関連付け】 を選択

[![Image from Gyazo](https://i.gyazo.com/e464933a835e46e768b8fa0532fd3ed6.png)](https://gyazo.com/e464933a835e46e768b8fa0532fd3ed6)

---

- 【2. サブネットの作成手順】 で作成したサブネット2個を選択

[![Image from Gyazo](https://i.gyazo.com/0d83c7c42668a9455332203255436208.png)](https://gyazo.com/0d83c7c42668a9455332203255436208)

---

- 下記の画像のようにサブネット達が上側に移動されていれば完了

[![Image from Gyazo](https://i.gyazo.com/f03d204b16fd00d16758bed903659830.png)](https://gyazo.com/f03d204b16fd00d16758bed903659830)

## 5. セキュリティグループ の作成手順

:::info
セキュリティグループ(以降､SG)
こちらの作業はEC2や各種サービスでインスタンスを作成する際に､作業を行う事もできる｡
:::

-  イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/60bfd330fdef3e9da500fe1940bc7ce9.png)](https://gyazo.com/60bfd330fdef3e9da500fe1940bc7ce9)

---

- VPC ダッシュボードから 【セキュリティグループ】 を選択
- 【セキュリティグループの作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/07e0d11f2dd1c6de01b708d241a03a58.png)](https://gyazo.com/07e0d11f2dd1c6de01b708d241a03a58)

---

- 【セキュリティグループ名】 に任意の名前を入力
	- 用途に合った最適な名前を命名
- 【説明】 に用途などを記述
	- 日本語は受け付けない､英語のみ
		:::spoiler
		[![Image from Gyazo](https://i.gyazo.com/2cda8192847ac99e41ad20ee602877a6.png)](https://gyazo.com/2cda8192847ac99e41ad20ee602877a6)
		:::
- 【VPC】 に 『1. VPCの作成手順』 を選択

[![Image from Gyazo](https://i.gyazo.com/d5fc723464635c496117aeda9c2b0fd8.png)](https://gyazo.com/d5fc723464635c496117aeda9c2b0fd8)

---

- 対象の SG を選択後に 【インバウンドのルール】 を選択
- 【ルールの編集】 を選択

[![Image from Gyazo](https://i.gyazo.com/dbc72a12f9753485d60918f790c9da6b.png)](https://gyazo.com/dbc72a12f9753485d60918f790c9da6b)

---

- インバウンドのルールの編集

	| タイプ | プロトコル | ポート開放 | ケース | 説明 |
	|:--:|:--:|:--:|:--|:--:|
	|HTTP|TCP|80|[カスタム] [0.0.0.0/0]||
	|HTTPS|TCP|443|[カスタム] [0.0.0.0/0]||

[![Image from Gyazo](https://i.gyazo.com/c6b7307f6396eece636d26e3d55844f3.png)](https://gyazo.com/c6b7307f6396eece636d26e3d55844f3)

---

- ==確認項目== 対象の SG の 【インバウンドルール】 で下記項目を確認
	
	| タイプ | プロトコル | ポート開放 | ケース | 説明 |
	|:--:|:--:|:--:|:--|:--:|
	|HTTP|TCP|80|[カスタム] [0.0.0.0/0]||
	|HTTPS|TCP|443|[カスタム] [0.0.0.0/0]||

[![Image from Gyazo](https://i.gyazo.com/41f6380edb368f6dd186f826166d0955.png)](https://gyazo.com/41f6380edb368f6dd186f826166d0955)

## 6. 作成したVPCでEC2を起動！

- イメージ完成図

[![Image from Gyazo](https://i.gyazo.com/4fe30396e4c7c3abb565900f35697cc9.png)](https://gyazo.com/4fe30396e4c7c3abb565900f35697cc9)

---

11月28日の時にEC2を作成した手順でステップ3で下記のように指定

[![Image from Gyazo](https://i.gyazo.com/e76391e9bde33d1214aeab915c5ab6c8.png)](https://gyazo.com/e76391e9bde33d1214aeab915c5ab6c8)

---
---

# アンケート

:::info
アンケートの回答自体は任意です｡
また名前の記載は任意です｡
:::

改善点や要望そして､相談などがあれば気軽にフォームに送って頂いて構いません｡

[回答フォーム](https://forms.gle/arfE9ndzwc86YYVp8)

# 余談

この手順書を作るにあたってシャッチョーと話した内容↓

[![Image from Gyazo](https://i.gyazo.com/4902fe760ac2927e5568bc56307dbdd1.jpg)](https://gyazo.com/4902fe760ac2927e5568bc56307dbdd1)