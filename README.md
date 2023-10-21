# terraform-hello-world

## 環境

- Windows 11 Home 22H2
- WSL2
  - Ubuntu
- AWS CLI インストール済み
- AWS Credential 設定済み

## tfenv と terraform のインストール

Terraform の複数のバージョン管理することができるツール。

```
git clone https://github.com/tfutils/tfenv.git .tfenv
cat << "_EOF_" >> .bashrc
export PATH=$PATH:~/.tfenv/bin
_EOF_
source .bashrc

tfenv install latest
tfenv use latest
```

## 準備

### 変数定義

`./terraform/terraform.tfvars`をプロジェクト用に設定する。

### キーの作り方

```
# 既存のSSHキーが存在するか確認
% ls -al ~/.ssh

# 未使用の無駄なSSHキーがあれば削除しておく
% rm -rf ~/.ssh/未使用のキー

# RSA4096ビット形式のSSHキーを作成する
% ssh-keygen -t rsa -b 4096

 ↓ 質問に答えていく
# SSHキーの保存先パスとファイル名を決める
#  -> そのままEnterと押すと()内のデフォルト値で生成される
#    ※ 今回は「keypair_aws」としている
Enter file in which to save the key (/Users/ユーザー名/.ssh/id_rsa): /Users/ユーザー名/.ssh/keypair_aws

# SSHキーのパスフレーズ設定
Enter passphrase (empty for no passphrase): 任意のパスワードを入力

# パスフレーズの再確認
Enter same passphrase again: 再度パスワードを入力

 ↓　入力が完了すると、秘密鍵と公開鍵が生成される

Your identification has been saved in /Users/ユーザー名/.ssh/keypair_aws.
Your public key has been saved in /Users/ユーザー名/.ssh/keypair_aws.pub.

# 生成されたSSHキーの確認
% ls -al ~/.ssh
```

## 初期化

初めに必ず実行する必要があります。
ワークスペースの初期化やプラグインがダウンロードされます。

```
cd terraform
terraform init
```

## リソースの構築

AWSにリソースを構築します。

```
terraform apply
    yesを入力してenter
```

## リソースの破棄

`terraform apply`で構築したリソースを破棄します。

```
terraform destroy
    yesを入力してenter
```

## EC2

EC2 Instance Connectを使う
SSHはできない

## 参考

- https://qiita.com/kamatama_41/items/ba59a070d8389aab7694
- https://qiita.com/Shuhei_Nakada/items/68bb082c0e5085b22a16#-alb
- https://qiita.com/ymd65536/items/327c05a8685d375a7e77
- https://github.com/inayuky/terraform-sampler

