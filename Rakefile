# frozen_string_literal: true

require 'csv'
require_relative './script/converters/pronounce_to_kana'

# rubocop:disable Metrics/BlockLength
namespace :generate do
  desc 'かなを付与したCSVファイルを生成します'
  task :csv, [:dry, :rows] do |_, args|
    unless args.dry.to_s == ''
      puts '実際に書き込みは行わずに結果をプレビューします'
    end

    keys = [
      '辞書ページ',
      '見出し語',
      'かな1',
      'かな2',
      'かな3',
      'アクセント型',
      '品詞',
      '文語などの種別',
      '補足',
      '意味 1.',
      '意味 2.',
      '意味 3.',
      '意味 4.',
      '意味 5.',
      '備考'
    ]

    csv_data = CSV.generate do |out_csv|
      out_csv << keys

      CSV.read('data/okinawa1.csv', headers: true).each.with_index(1) do |row, index|
        row << ['かな1', ::Converters::PronounceToKana.convert(row['見出し語'])]

        # TODO　ラ行動詞は=junは"いん"と"ゆん"の見出し語を作る
        row << ['かな2', nil]

        # TODO　士族の言葉も作る
        row << ['かな3', nil]

        out_csv << keys.map { |key| row[key] }

        break if args.rows.to_i.positive? && index >= args.rows.to_i
      end
    end

    if args.dry.to_s == ''
      File.write('data/okinawa2.csv', csv_data)
    else
      puts csv_data
    end
  end

  desc 'データベースの初期データを生成するSQLを生成します'
  task :seed_sql do
    # TODO: 作業中
  end
end
# rubocop:enable Metrics/BlockLength
