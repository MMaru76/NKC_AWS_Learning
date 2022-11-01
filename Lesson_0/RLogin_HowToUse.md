# RLogin 使い方

## RLogin とは

RLoginは、Windows上で動作するターミナルソフトです。

プロトコルはrlogin,telnet,ssh(バージョン１と２)の3種類に対応し遠隔でのサーバーメンテナンスを考えて安全な暗号化通信をサポートしています。

漢字コードは、EUC,SJIS,UTF-8などに対応しISO-2022によるバンク切り替えで様々な文字コードが表示できます。

画面制御としてxtermに準じたエスケープシーケンスなどに対応しANSIやvt100コンソールとして使用する事ができます。

## 配布リンク

[RLogin](http://nanno.dip.jp/softlib/man/rlogin/)

特に指定がなければ､｢実行プログラム(64bit)｣をダウンロードすればOK

## NKC にて 【SSH】 で外部サーバにアクセスする方法

| 項目 | 値 |
|:--:|:--:|
| ホスト名 |インスタンスの PublicIP|
|ログインユーザー名|ec2-user|
|TCPポート|443|
|プロキシ設定|選択|

![8c3bc6a810909833b323764ea4195004](https://user-images.githubusercontent.com/20497766/199161232-c102e060-e3fc-42aa-a036-f52110d2073e.png)


---

| 項目 | 値 |
|:--:|:--:|
|Select Proxy Protocol|HTTP|
|Over SSL|使用しない|
|Proxy Server Address|proxy.denpa.ac.jp|
|Socket Port|8080|

![714f286ff550522ec9aa7538ba69adf6](https://user-images.githubusercontent.com/20497766/199161276-78374535-d3e1-4620-8668-4b9bd09039bb.png)
