# frozen_string_literal: false

require_relative './table'
require_relative './convert_error'

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/BlockNesting
module Converters
  class PronounceConverter
    def self.pronounce_to_kana(pronounce, by_warrior = false)
      table =
        if by_warrior
          ::Converters::Table::TABLE_WARRIOR
        else
          ::Converters::Table::TABLE_COMMONER
        end

      text = pronounce
      is_head_of_word = true
      last_char = ''
      out = ''

      while text&.size&.positive?
        # 声門破裂音
        if text.start_with?('?')
          case text
          when /^\?([aiueo])/
            char = table[::Regexp.last_match(1)]
            out << char
          when /^\?(ja|ju|jo|me|wa|wi|we)/
            char = table[::Regexp.last_match(1)]
            out << 'っ'
            out << char
          when /^\?([nN])[^aiueo]/
            char = table[::Regexp.last_match(1)]
            out << 'っ'
            out << char
          else
            raise ::Converters::ConvertError, pronounce
          end
          last_char = text[::Regexp.last_match(1).length]
          text = text[(::Regexp.last_match(1).length + 1)..]
        elsif text.start_with?('\'')
          case text
          when /^'(i|u|e|o)/
            char = table[::Regexp.last_match(1)]
            out << to_sutegana(char)
            out << char
          when /^'([N|n]{1,2})/
            char = table[::Regexp.last_match(1)]
            out << char
          when /^'(w(a|i|e))/
            char = table[::Regexp.last_match(1)]
            out << char
          when /^'(j(a|u|o))/
            char = table[::Regexp.last_match(1)]
            out << char
          else
            raise ::Converters::ConvertError, pronounce
          end

          last_char = text[::Regexp.last_match(1).length]
          text = text[(::Regexp.last_match(1).length + 1)..]
        else
          case text
          when /^([aiueo])/
            # 前の文字と母音が同じなら長音”ー”に置き換える
            if last_char == ::Regexp.last_match(1)
              out << 'ー'
            else
              char = table[::Regexp.last_match(1)]
              # 行頭のみ捨て仮名を前に付与
              out << to_sutegana(char) if is_head_of_word
              out << char
            end
          when /^(nN)[^aiueo]/, \
            /^(ja|ju|jo|hja|hju|hjo|bja|bju|bjo|pja|pju|pjo|mja|mju|mjo|rja|rju|rjo|wa|wi|we|kwa|kwi|kwe|gwa|gwi|gwe)/
            out << table[::Regexp.last_match(1)]
          when /^((k|g|s|S|sj|z|Z|t|d|c|C|n|h|hw|p|P|b|bw|m|r)[aiueo])/
            out << table[::Regexp.last_match(1)]
          when /^(hN)/
            out << table[::Regexp.last_match(1)]
          when /^([nN])/
            out << table[::Regexp.last_match(1)]
          when /^([-=、\\.])/
            out << table[::Regexp.last_match(1)]
          when /^([qQ])[kCsStcmnpP\]=]/
            out << table[::Regexp.last_match(1)]
          when /^([qQ])$/
            out << table[::Regexp.last_match(1)]
          when /^([\]()\s])/
            # discard
          else
            raise ::Converters::ConvertError, pronounce
          end

          if ::Regexp.last_match(1)
            last_char = text[::Regexp.last_match(1).length - 1]
            text = text[::Regexp.last_match(1).length..]
          else
            last_char = ''
            text = text[1..]
          end
        end

        is_head_of_word = ::Regexp.last_match(1) && [',', '、'].include?(::Regexp.last_match(1))
      end

      out
    end

    # 捨て仮名「ぁぃぅぇぉ」
    def self.to_sutegana(char)
      (char.ord - 1).chr('UTF-8')
    end
  end
end

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/BlockNesting
