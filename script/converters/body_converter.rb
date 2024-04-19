# frozen_string_literal: false

require_relative './pronounce_converter'

# 辞書データの本文中の発音記号を仮名に変換する
module Converters
  class BodyConverter
    def self.convert_body(str)
      return nil unless str

      res = str.dup
      pos = 0

      while (matched = /[\\?']?[\]A-Za-z]{2,}[\\.]?/.match(res, pos))
        begin
          case matched[0]
          # 英単語は置換対象外
          when 'self', 'apocopatedform', 'apocopated', 'form'
            pos = matched.begin(0) + matched[0].size
          else
            replaced = ::Converters::PronounceConverter.pronounce_to_kana(matched[0])
            res.sub!(matched[0], replaced)
          end
        rescue ::Converters::ConvertError => _e
          puts '変換エラー:'
          puts str
          raise
        end
      end

      res
    end
  end
end
