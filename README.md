# Gyazoにアップロードされている画像を一括ダウンロードしてくる
Gyazoにアップロードされている画像を一括でダウンロードしてくるスクリプト
ファイル名と作成日などは全部Gyazoのcreated_atにて保存してくれます

# 使い方

```
$ git clone https://github.com/henteko/gyazo_downloader.git
$ cd gyazo_downloader
$ vim download.rb
# your_gyazo_token部分を自分のtokenに変更
$ bundle install
$ bundle exec ruby download.rb
```
