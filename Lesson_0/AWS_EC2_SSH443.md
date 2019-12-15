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

[![Image from Gyazo](https://i.gyazo.com/176ca7a02c578a28d8e7042f28883038.gif)](https://gyazo.com/176ca7a02c578a28d8e7042f28883038)

---

## ファイルを使う場合

【ファイルとして】→ファイルを指定

[![Image from Gyazo](https://i.gyazo.com/3d20818d3be4d9721af452447d4dea7c.gif)](https://gyazo.com/3d20818d3be4d9721af452447d4dea7c)