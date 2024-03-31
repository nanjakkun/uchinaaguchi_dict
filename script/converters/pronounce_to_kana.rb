require_relative './table.rb'

module Converters
  class PronounceToKana
    def self.convert(pronounce, by_warrior=false)
      table =
        if by_warrior
          ::Converters::Table::TABLE_WARRIOR
        else
          ::Converters::Table::TABLE_COMMONER
        end

      is_head_of_word = true
      text = pronounce
      out = ''

      while (text && text.size > 0)
        # 声門破裂音
        if text.start_with?('?')
          case text
          when /^\?([aiueo])/
            char = table[$1]
            out << char
          when /^\?(ja|ju|jo|me|wa|wi|we)/
            char = table[$1]
            out << 'っ'
            out << char
          when /^\?([nN])[^aiueo]/
            char = table[$1]
            out << 'っ'
            out << char
          else
            raise ArgumentError.new(pronounce)
          end
          text = text[($1.length+1)..]
        elsif text.start_with?('\'')
          case text
          when /^\'(i|u|e|o|N|n)/
            char = table[$1]
            out << char
          when /^\'(w(a|i|e))/
            char = table[$1]
            out << char
          when /^\'(j(a|u|o))/
            char = table[$1]
            out << char
          else
            raise ArgumentError.new(pronounce)
          end

          text = text[($1.length+1)..]
        else
          case text
          when /^([aiueo])/
            # TODO: 前の文字と母音が同じなら長音”ー”に置き換える

            char = table[$1]
            # 行頭のみ捨て仮名を前に付与
            if is_head_of_word
              out << self.to_sutegana(char)
            end
            out << char
          when /^(nN)[^aiueo]/, /^(ja|ju|jo|hja|hju|hjo|bja|bju|bjo|pja|pju|pjo|mja|mju|mjo|rja|rju|rjo|wa|wi|we|kwa|kwi|kwe|gwa|gwi|gwe)/
            out << table[$1]
          when /^((k|g|s|S|sj|z|Z|t|d|c|C|n|h|hw|p|b|bw|m|r)[aiueo])/
            out << table[$1]
          when /^(hN)/
            out << table[$1]
          when /^([nN])/
            out << table[$1]
          when /^([-=、])/
            out << table[$1]
          when /^([qQ])[kCsStcmnp\]=]/
            out << table[$1]
          when /^([qQ])$/
            out << table[$1]
          when /^([\]\(\)\s])/
            # discard
          else
            raise ArgumentError.new(pronounce)
          end

          if $1
            text = text[$1.length..]
          else
            text = text[1..]
          end
        end

        is_head_of_word = ($1 && $1 == '=')
      end

      out
    end

    # 捨て仮名「ぁぃぅぇぉ」
    def self.to_sutegana(char)
      (char.ord - 1).chr('UTF-8')
    end
  end
end
