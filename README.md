# memo

github上にリポジトリを作ってローカルにclone

    git clone git@xxxx


Heroku使うのでポスグレで

    rails new . --database=postgresql

以下gemを追加

    gem 'line-bot-api'
    gem 'dotenv-rails'

適当にcontrollerを作る。今回はechoesにした（echoするだけだから）

    rails g controller echoes

routing設定する。

    resources :echos, only [:index, :create]

* indexは表示確認用
* createをWebHook URLに使う（これがメイン）

サンプルを参考にactionを実装する
[これはsinatraだけど大体こんなかんじ](https://github.com/line/line-bot-sdk-ruby)

忘れがちなHerokuの最低限の使い方

* heroku login : ログインしておく
* heroku create : Heroku上にアプリを作る
* git push heroku master : デプロイ

Herokuに環境変数を設定する。

    heroku config:set LINE_CHANNEL_SECRET=xxxx
    heroku config:set LINE_CHANNEL_TOKEN=xxxx

* LINE_CHANNEL_TOKENは「メッセージ送受信設定」でアクセストークンを再発行すると出る
* LINE_CHANNEL_SECRETは「基本情報」に表示されてる

開発環境用の環境変数はdotenv_railsで設定する。.envファイルを作ってそこに書けばOK

    LINE_CHANNEL_SECRET=xxxx
    LINE_CHANNEL_TOKEN=xxxx

