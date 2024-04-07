# frozen_string_literal: true

require 'csv'
require 'rake/testtask'

require_relative './script/converters/pronounce_to_kana'

# rubocop:disable Metrics/BlockLength
namespace :generate do
  desc 'かなを付与したCSVファイルを生成します'
  task :csv, [:dry, :rows] do |_, args|
    unless args.dry.to_s == ''
      puts '実際に書き込みは行わずに結果をプレビューします'
    end

    keys = [
      'id',
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
        row['id'] = index
        row << ['かな1', ::Converters::PronounceToKana.convert(row['見出し語'])]

        # =juNで終わる動詞は"いん"と"ゆん"の見出し語を作る
        row <<
          if row['見出し語'].end_with?('=juN')
            ['かな2', ::Converters::PronounceToKana.convert(row['見出し語'].sub(/=juN/, '=in'))]
          else
            ['かな2', nil]
          end

        # 士族の発音が違う場合は”かな3"へ追記
        row <<
          if %w[sj Z C].any? { |chars| row['見出し語'].include?(chars) }
            ['かな3', ::Converters::PronounceToKana.convert(row['見出し語'], true)]
          else
            ['かな3', nil]
          end

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

Rake::TestTask.new do |test|
  test.test_files = Dir['script/**/*_test.rb']
  test.verbose = true
end

require 'jekyll/vite'
ViteRuby.install_tasks

# rubocop:enable Metrics/BlockLength
