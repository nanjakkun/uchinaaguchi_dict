# Uchinaaguchi Dict

沖縄語辞典(うちなーぐち辞典)


# 元データとライセンス

国立国語研究所資料集5『沖縄語辞典』
https://mmsrv.ninjal.ac.jp/okinawago/

沖縄語辞典 データ集は クリエイティブ・コモンズ 表示 4.0 国際 ライセンスの下に提供されています。
クリエイティブ・コモンズ・ライセンス
https://creativecommons.org/licenses/by/4.0/


# 改変項目

- 誤字、誤植、文字化けの修正
- 見出し語が元データでは独自の発音記号であったが、ひらがな表記を追加


# dataフォルダ内のファイル

- okinawa.xlsx: 国立国語研究所で配布されている元データ
- okinawa1.csv: okinawa.xlsxをCSV化したもの（若干誤字等の修正あり）
- okinawa2.csv: okinawa1.csvに仮名の読みを付与したもの


# ローカルで動かすための要件

Ruby

# インストール

```bash
gem install bundler
bundle install
```

# 変換スクリプトの実行

```bash
bundle exec rake generate:csv[1,100] # プレビュー(先頭100件)

bundle exec rake generate:csv[] # 本実行
```

# 変換スクリプトのユニットテスト(Ruby)

```bash
bundle exec rake test
```

# 静的サイトの立ち上げ(ローカル)

```bash
bundle exec jekyll serve
```

