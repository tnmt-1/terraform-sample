# terraform-hello-world

以下構成の環境を構築する。

![](https://d1tlzifd8jdoy4.cloudfront.net/wp-content/uploads/2023/01/20230127_simplebuild_07.png)

引用: https://dev.classmethod.jp/articles/release-aws-simple-build-package/

## 環境

- Windows 11 Home 22H2
- WSL2
  - Ubuntu
- AWS CLIインストール済み
- AWS Credential設定済み

## tfenvとTerraformのインストール

tfenvはTerraformの複数のバージョン管理することができるツールです。tfenvを使ってTerraformをインストールします。

```bash
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

`./terraform/terraform.tfvars`をプロジェクト用に設定します。

```bash
cp terraform.tfvars.sample terraform.tfvars
```

## 初期化

初めに必ず実行する必要があります。
ワークスペースの初期化やプラグインがダウンロードされます。

```
terraform -chdir=terraform init
```

## チェック

変更内容が表示されます。
コードを作成、変更した場合は、terraform planすることで実行内容に問題ないかを確認します。

```
terraform -chdir=terraform plan
```

## リソースの構築

AWSにリソースを構築します。

```
terraform -chdir=terraform apply
※「yes」を入力してenter
```

以下のように質問が来るので、「yes」を入力してenterする

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```

## リソースの破棄

`terraform apply`で構築したリソースを破棄します。

```
terraform -chdir=terraform destroy
```

以下のように質問が来るので、「yes」を入力してenterする

```
Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes
```

## EC2

EC2 Instance Connectを使います。SSHはできません。

## RDS

EC2から接続可能です。外部からのアクセスはできません。
接続パスワードは、パラメータストアに保存されています。

メモ
```
mysql -u admin -p -h xxx.ap-northeast-1.rds.amazonaws.com -P 3306
```

## 参考

- https://qiita.com/kamatama_41/items/ba59a070d8389aab7694
- https://qiita.com/Shuhei_Nakada/items/68bb082c0e5085b22a16#-alb
- https://qiita.com/ymd65536/items/327c05a8685d375a7e77
- https://github.com/inayuky/terraform-sampler
