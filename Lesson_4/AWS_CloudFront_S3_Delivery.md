# AWS CloudFront+S3 で静的サイトを配信

最初にS3を作ってから､そのあとにCloudFrontを作ります｡<br>
不明な単語が出たら随時､各自で調べてみましょう｡

｢さくらインターネット｣ の社長さんのBlogやTwitterを参考<br>
[大災害時におけるアクセス負荷を軽減させるキャッシュサーバ提供について](https://tanaka.sakura.ad.jp/2011/03/cache-cdn-server.html)
[Twitter](https://twitter.com/kunihirotanaka/status/1008496434562265088)

# 事前準備編

下記は各自で準備

- 適当な画像
	- どんな画像でも可
	- ファイル名は自由
- 適当なHTMLファイルを準備
	- 『Hello world』 とかでも可
	- ファイル名は ｢index.html｣

# AWS S3 編

## 【S3】 サービス画面へ移動

【サービス】→検索窓にて ｢s3｣ と入力→ヒットしたのを選択

[![Image from Gyazo](https://i.gyazo.com/5beb230e2973f03880fc8cdb55d589cf.png)](https://gyazo.com/5beb230e2973f03880fc8cdb55d589cf)

---

## 【S3】 バケットの作成

【+ バケットを作成する】 を選択

[![Image from Gyazo](https://i.gyazo.com/7d273a864776bc72a58dd982e870d654.png)](https://gyazo.com/7d273a864776bc72a58dd982e870d654)

---

【バケット名】 は､ 一意 な値を入力
【リージョン】 は､ ｢米国東部(バージニア北部)｣ を選択

[![Image from Gyazo](https://i.gyazo.com/fc3adc9b726d0bb8e47f0cf7ecbb6e5c.png)](https://gyazo.com/fc3adc9b726d0bb8e47f0cf7ecbb6e5c)

---

なにも選択せず 【次へ】

[![Image from Gyazo](https://i.gyazo.com/49f6c793513e4ea4afcad52c5bc26a92.png)](https://gyazo.com/49f6c793513e4ea4afcad52c5bc26a92)

---
なにも選択せず 【次へ】

[![Image from Gyazo](https://i.gyazo.com/64956600f353a4de5b04a0eef9a8d9eb.png)](https://gyazo.com/64956600f353a4de5b04a0eef9a8d9eb)

---
【バケットを作成】 を選択

[![Image from Gyazo](https://i.gyazo.com/fc3dd383b8a73ecff55a3f123ab74a3f.png)](https://gyazo.com/fc3dd383b8a73ecff55a3f123ab74a3f)

---

## 【S3】 ファイルまたは画像をアップロード

作成したバケットを選択

[![Image from Gyazo](https://i.gyazo.com/04614d61fd80365f978d24f4240d3b05.png)](https://gyazo.com/04614d61fd80365f978d24f4240d3b05)

【アップロード】 を選択
[![Image from Gyazo](https://i.gyazo.com/2e609454095169db0a993e4bf6ec5a80.png)](https://gyazo.com/2e609454095169db0a993e4bf6ec5a80)

---

1. 【ファイルを追加】 を選択
	- 各自で準備した 【(HTML)ファイルと画像】 を選択
2. 【次へ】 を選択
3. 【次へ】 を選択
4. 【アップロード】 を選択

[![Image from Gyazo](https://i.gyazo.com/1ec76ac19e9a27e66696a091c992d9e2.gif)](https://gyazo.com/1ec76ac19e9a27e66696a091c992d9e2)

---

下記の様にファイルと画像がアップロードされていれば完了

[![Image from Gyazo](https://i.gyazo.com/68687b63a6b4ca9fea8ca5b8298b5553.png)](https://gyazo.com/68687b63a6b4ca9fea8ca5b8298b5553)

---

アップロードしたファイルまたは画像を選択して､【オブジェクト URL】 を選択

[![Image from Gyazo](https://i.gyazo.com/4a62f9274511350e7aa9cd4cd94a1945.png)](https://gyazo.com/4a62f9274511350e7aa9cd4cd94a1945)

下記の様に､変な文字列が出たら正しいです｡
パブリックのアクセス権限が無いと言われています｡

[![Image from Gyazo](https://i.gyazo.com/e0d3cbbbfc5910ec56c9d3732dc7effc.png)](https://gyazo.com/e0d3cbbbfc5910ec56c9d3732dc7effc)

---
---

# AWS CloudFront 編

## 【CloudFront】 サービス画面へ移動

【サービス】→検索窓にて ｢CloudFront｣ と入力→ヒットしたのを選択

[![Image from Gyazo](https://i.gyazo.com/fd1829bebffc0cf34b83cbc921310df3.png)](https://gyazo.com/fd1829bebffc0cf34b83cbc921310df3)

---

## 【CloudFront】 CFの作成

【Create Distribution】 を選択

[![Image from Gyazo](https://i.gyazo.com/e89964a2afd891ecf5d7534dd78315a9.png)](https://gyazo.com/e89964a2afd891ecf5d7534dd78315a9)

Webの方の 【Get started】 を選択

[![Image from Gyazo](https://i.gyazo.com/5cdf6b672c498963b94180df89e860ee.png)](https://gyazo.com/5cdf6b672c498963b94180df89e860ee)

---

- 【Origin DOmain Name】
	- クリックすると､先程作成したバケットがあるので選択
- 【Origin ID】
	- 自動入力
- 【Restrict Bucket Access】
	- 【Yes】 を選択
- 【Origin Access Identity】
	- 【Create a New Identity】 を選択
- 【Comment】
	- 好きな名前を入力
- 【Grant Read Permissions on Bucket】
	- 【Yes,~】 を選択

[![Image from Gyazo](https://i.gyazo.com/8d47d748991dbc7277cd77ce58ca2518.png)](https://gyazo.com/8d47d748991dbc7277cd77ce58ca2518)

---

- 【Viewer Protocol Policy】
	- 【Redirect HTTP to HTTPS】 を選択すればHTTPSにリダイレクト

[![Image from Gyazo](https://i.gyazo.com/64daefe627a22cbe9a71b9d73365b855.png)](https://gyazo.com/64daefe627a22cbe9a71b9d73365b855)

---

- 【Default Root Object】
	- 【index.html】 と入力

[![Image from Gyazo](https://i.gyazo.com/20f535d835d0bc615c546b6b81df53f1.png)](https://gyazo.com/20f535d835d0bc615c546b6b81df53f1)

---

## 【CloudFront】 少々待つ

結構時間が掛かる場合があるから､気長に待つしか無い｡

[![Image from Gyazo](https://i.gyazo.com/be4ed1fd157f1997316adde049a29772.png)](https://gyazo.com/be4ed1fd157f1997316adde049a29772)

---

## 【CloudFront】 自分で作ったページにアクセスしてみよう｡

【Domain Name】 をコピーして､Googleに投げる

[![Image from Gyazo](https://i.gyazo.com/0d315b166819bb561b7ac26b72a891db.png)](https://gyazo.com/0d315b166819bb561b7ac26b72a891db)

---

トップページにアクセスすると下記の様に表示されるはず｡

[![Image from Gyazo](https://i.gyazo.com/65f3534708b4d94a2ebe850fe4d99bb8.png)](https://gyazo.com/65f3534708b4d94a2ebe850fe4d99bb8)

更には､S3にアップロードした画像のファイル名+拡張子を入力してあげると下記のようになる｡

[![Image from Gyazo](https://i.gyazo.com/28c32698fdd4897d4c8527f316e26c11.png)](https://gyazo.com/28c32698fdd4897d4c8527f316e26c11)