# localstack-docker
AWS Lambdaのローカル環境検証用
Lambdaランタイム=Node.js18 

# 初期設定

- AWS CLIの設定
```
sudo apt  install awscli
aws --version
```

- ダミーのconfigを作成
```
aws configure --profile localstack
AWS Access Key ID [None]: dummy
AWS Secret Access Key [None]: dummy
Default region name [None]: us-east-1
Default output format [None]: json
```

- docker-compsse.ymlが配置されているディレクトリに移動

- envファイルを作成
```
cp .env.example .env
```

- tmpディレクトリを作成(上のenvファイルの設定に合わせて)
```
mkdir -p ./tmp/localstack
```

- サービスの立ち上げ
```
docker-compose up -d --build
```


## 説明
LocalStack コンテナ内には awslocal がデフォルトでインストールされているため、コンテナ内部で`aws`コマンドを実行する場合には`awslocal`コマンドを使用できる。
```
docker compose exec localstack awslocal <command>
```

- ローカルLambdaにデプロイ
```
make lambdaBuild FUNCTION_NAME=lambda-function-name
```

- すでに作成されているLambda関数を削除
```
make lambdaDestroy FUNCTION_NAME=lambda-function-name
```

- Lmabda関数の状態を確認
```
make lambdaStatus FUNCTION_NAME=lambda-function-name
```