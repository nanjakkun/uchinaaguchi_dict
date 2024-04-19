# frozen_string_literal: true

require_relative './converters/pronounce_converter'
require_relative './converters/body_converter'

class Converter
  SOURCE_FILE = 'data/okinawa1.csv'

  KEYS = [
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
  ].freeze

  # rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/BlockLength

  # @param rows [Integer, nil] 出力行数
  # @return CSV
  def self.convert(rows: nil)
    CSV.generate do |out_csv|
      # ヘッダ
      out_csv << KEYS.dup

      CSV.read(SOURCE_FILE, headers: true).each.with_index(1) do |row, index|
        row['id'] = index
        row << ['かな1', ::Converters::PronounceConverter.pronounce_to_kana(row['見出し語'])]

        # =juNで終わる動詞は"いん"と"ゆん"の見出し語を作る
        row <<
          if row['見出し語'].end_with?('=juN')
            ['かな2', ::Converters::PronounceConverter.pronounce_to_kana(row['見出し語'].sub(/=juN/, '=in'))]
          else
            ['かな2', nil]
          end

        # 士族の発音が違う場合は”かな3"へ追記
        row <<
          if %w[sj Z C].any? { |chars| row['見出し語'].include?(chars) }
            ['かな3', ::Converters::PronounceConverter.pronounce_to_kana(row['見出し語'], true)]
          else
            ['かな3', nil]
          end

        out_csv << KEYS.map do |key|
          # カンマを読点に変換
          # - CSVの扱いが楽になるように
          # - 日本語、沖縄語の文章にカンマが入ると不自然なので
          column_data = row[key]

          if ['意味 1.', '意味 2.', '意味 3.', '意味 4.', '意味 5.'].include?(key)
            ::Converters::BodyConverter.convert_body(column_data)&.tr(',', '、')
          elsif column_data.is_a?(String)
            column_data.tr(',', '、')
          else
            column_data
          end
        end

        break if rows.to_i.positive? && index >= rows.to_i
      end
    end
  end
  # rubocop:enable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity,Metrics/BlockLength
end
