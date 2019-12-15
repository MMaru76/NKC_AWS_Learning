# 追加課題の解答 踏み台 20191203

追加課題のURL
[追加課題の解答 踏み台 20191203](./AWS_Springboard.md)

コマンドプロンプトでのアクセスしたい方は､下記を見てください｡
[sshをWindowsコマンドプロンプトで実行する手順](https://www.eaton-daitron.jp/techblog/4627.html)

(僕の方では一切試していません｡[WSL](https://www.pc-koubou.jp/magazine/21475) や [Gig Bash](https://www.sejuku.net/blog/72673) で良いと思っている｡)

## 0. 概要

1. 各種 Instance1/2 の作成
2. 鍵の転送方法手順
3. Instance2 に SSH 接続

## 1. 各種 Instance の作成

### 【PublicSubnet】 Instance1作成手順


- PublicSubnet に対してインスタンスを作成
- 【自動割り当てパブリックIP】 の 【有効】 を選択

---

### 【PrivateSubnet】 Instance2作成手順

- PrivateSubnet に対してインスタンスを作成
- 【自動割り当てパブリックIP】 の 【無効】 を選択

[![Image from Gyazo](https://i.gyazo.com/1cfb7278105575ae783f86fe88a7f425.png)](https://gyazo.com/1cfb7278105575ae783f86fe88a7f425)

---

### 完成図

[![Image from Gyazo](https://i.gyazo.com/5367e88f31e229918c45e6876386f183.png)](https://gyazo.com/5367e88f31e229918c45e6876386f183)

## 2. 鍵の転送方法手順

鍵の転送方法は何を使って転送してもらっても問題ない｡
普通に秘密鍵(*SecretKey*)のファイルをエディター等で開いて､Instances2にコピペしても良い｡

---

### 一番美しくない転送の仕方

- *SecretKey.pem* のファイルをエディター等で開く
	- メモ帳以外で開く
- 中身を全てコピー
- 『Instance1』 にアクセス後に下記のコマンドを実行してコピーしたものを全てペースト

```bash
$ vim ~/.ssh/SecretKey.pem
$ chmod 400 ~/.ssh/SecretKey.pem
```
> 鍵の転送の仕方のGIF
![](https://i.imgur.com/k65Ufpg.gif)

---

### 【GUI】 FileZillaの場合

ダウンロードリンク → [FileZilla](https://ja.osdn.net/projects/filezilla/)

僕はFileZillaというアプリを使っていますが､皆さんが各自で調べて出てきたものでも大丈夫です｡

また､学校の回線では検証出来ていないのと､学校回線だと複雑になるため､もし自分でやってみたい方は自宅とかの回線で試してみましょう｡

---

### 【CUI】 WSLの場合

>WSLの時間が結構掛かる為､家での作業を推奨します｡
>僕が試した時は､学校回線では行けなかったはずなので､自宅で試してみてください｡
>こちらの環境構築方法は､｢[WSLでWindows 10にLinux仮想環境を構築](https://www.pc-koubou.jp/magazine/21475)｣を参考に各自で構築してください｡


- ローカルPCからのアクセス作業

```bash
$ cp /mnt/c/Users/PCのUser名/Downloads/SecretKey.pem .ssh/
$ chmod 400 .ssh/SecretKey.pem
$ scp -i .ssh/SecretKey.pem .ssh/SecretKey.pem  ec2-user@Instance1(PublicIP):/home/ec2-user/.ssh/
$ ssh -i "SecretKey.pem" ec2-user@Instance1(PublicIP)
```

- Instance1 での作業

```bash
$ ssh -i .ssh/SecretKey.pem ec2-user@Instance2(LocalIP)
```

## 3. Instance2 に SSH 接続

- Instance1から下記のコマンドを実行してアクセス
      - $(ドルマーク) の行だけ入力

```bash
[ec2-user@【Instance1のPrivateIP】 ~]$ ssh -i .ssh/SecretKey.pem ec2-user@【Instance2のPrivateIP】

The authenticity of host '【Instance2のPrivateIP】' can't be established.
Are you sure you want to continue connecting (yes/no)? yes 【yes と入力】

       __|  __|_  )
       _|  (     /   Amazon Linux AMI
      ___|\___|___|

[ec2-user@【Instance2のPrivateIP】 ~]$
```

