# EC2 インスタンスのSSHポートを443に変更

ワカラナイ場合は､まずは自分で考えてみよう｡
あとは､周りの学生と相談をしてみましょう｡

パブリックサブネットの中にEC2インスタンスを作成する際に､**『ステップ 3: インスタンスの詳細の設定』** で下記の設定をしてください｡

## 直書きの場合

【テキストで】→下記の4行をコピペ

```bash
#!/bin/bash
echo            >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
service sshd restart
```


https://user-images.githubusercontent.com/20497766/199161044-625813f2-3a30-4991-a0a8-d268b2c0f0a0.mp4


---

## ファイルを使う場合

【ファイルとして】→ファイルを指定



https://user-images.githubusercontent.com/20497766/199161061-85542e70-0b19-401b-b69d-ad47f25f785e.mp4

