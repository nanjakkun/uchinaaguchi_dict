module Converters
  class PronounceToKana
    CHAR_HASH = {
      'a' => 'あ',
      'i' => 'い',
      'u' => 'う',
      'e' => 'え',
      'o' => 'お',
      'ka' => 'か',
      'ki' => 'き',
      'ku' => 'く',
      'ke' => 'け',
      'ko' => 'こ',
      'kwa' => 'くゎ',
      'kwi' => 'くぃ',
      'kwe' => 'くぇ',
      'ga' => 'が',
      'gi' => 'ぎ',
      'gu' => 'ぐ',
      'ge' => 'げ',
      'go' => 'ご',
      'gwa' => 'ぐゎ',
      'gwi' => 'ぐぃ',
      'gwe' => 'ぐぇ',
      'sa' => 'さ',
      'si' => 'し',
      'su' => 'す',
      'se' => 'せ',
      'so' => 'そ',
      'Sa' => 'さ',
      'Si' => 'し',
      'Su' => 'す',
      'Se' => 'せ',
      'So' => 'そ',
      'za' => 'じゃ',
      'zi' => 'じ',
      'zu' => 'じゅ',
      'ze' => 'じぇ',
      'zo' => 'じょ',
      'Za' => 'ざ',
      'Zi' => 'じ',
      'Zu' => 'じゅ',
      'Ze' => 'ぜ',
      'Zo' => 'ぞ',
      'sja' => 'さ',
      'sji' => 'し',
      'sju' => 'す',
      'sje' => 'せ',
      'sjo' => 'そ',
      'ta' => 'た',
      'ti' => 'てぃ',
      'tu' => 'とぅ',
      'te' => 'て',
      'to' => 'と',
      'da' => 'だ',
      'di' => 'でぃ',
      'du' => 'どぅ',
      'de' => 'で',
      'do' => 'ど',
      'ca' => 'ちゃ',
      'ci' => 'ち',
      'cu' => 'ちゅ',
      'ce' => 'ちぇ',
      'co' => 'ちょ',
      'Ca' => 'ちゃ',
      'Ci' => 'ち',
      'Cu' => 'ちゅ',
      'Ce' => 'ちぇ',
      'Co' => 'ちょ',
      'na' => 'な',
      'ni' => 'に',
      'nu' => 'ぬ',
      'ne' => 'ね',
      'no' => 'の',
      'ha' => 'は',
      'hi' => 'ひ',
      'hu' => 'ふ',
      'he' => 'へ',
      'ho' => 'ほ',
      'hwa' => 'ふぁ',
      'hwi' => 'ふぃ',
      'hwu' => 'ふ',
      'hwe' => 'ふぇ',
      'hwo' => 'ふぉ',
      'hja' => 'ひゃ',
      'hju' => 'ひゅ',
      'hjo' => 'ひょ',
      'pa' => 'ば',
      'pi' => 'び',
      'pu' => 'ぶ',
      'pe' => 'べ',
      'po' => 'ぼ',
      'pja' => 'ぴゃ',
      'pju' => 'ぴゅ',
      'pjo' => 'ぴょ',
      'ba' => 'ば',
      'bi' => 'び',
      'bu' => 'ぶ',
      'be' => 'べ',
      'bo' => 'ぼ',
      'bwa' => 'ば',
      'bwi' => 'び',
      'bwu' => 'ぶ',
      'bwe' => 'べ',
      'bwo' => 'ぼ',
      'bja' => 'びゃ',
      'bju' => 'びゅ',
      'bjo' => 'びょ',
      'ma' => 'ま',
      'mi' => 'み',
      'mu' => 'む',
      'me' => 'め',
      'mo' => 'も',
      'mja' => 'みゃ',
      'mju' => 'みゅ',
      'mjo' => 'みょ',
      'ja' => 'や',
      'ju' => 'ゆ',
      'jo' => 'よ',
      'ra' => 'ら',
      'ri' => 'り',
      'ru' => 'る',
      're' => 'れ',
      'ro' => 'ろ',
      'rja' => 'りゃ',
      'rju' => 'りゅ',
      'rjo' => 'りょ',
      'wa' => 'わ',
      'wi' => 'うぃ',
      'we' => 'うぇ',
      'hN' => 'ふ',
      'n' => 'ん',
      'N' => 'ん',
      'q' => 'っ',
      'Q' => 'っ',
      '-' => '-',
      '=' => '=',
      '、' => '、',
    }

    def self.convert(pronounce)
      is_head_of_word = true
      text = pronounce
      out = ''

      while (text && text.size > 0)
        # 声門破裂音
        if text.start_with?('?')
          case text
          when /^\?([aiueo])/
            char = CHAR_HASH[$1]
            out << char
          when /^\?(ja|ju|jo|me|wa|wi|we)/
            char = CHAR_HASH[$1]
            out << 'っ'
            out << char
          when /^\?([nN])[^aiueo]/
            char = CHAR_HASH[$1]
            out << 'っ'
            out << char
          else
            raise ArgumentError.new(pronounce)
          end
          text = text[($1.length+1)..]
        elsif text.start_with?('\'')
          case text
          when /^\'(i|u|e|o|N|n)/
            char = CHAR_HASH[$1]
            out << char
          when /^\'(w(a|i|e))/
            char = CHAR_HASH[$1]
            out << char
          when /^\'(j(a|u|o))/
            char = CHAR_HASH[$1]
            out << char
          else
            raise ArgumentError.new(pronounce)
          end

          text = text[($1.length+1)..]
        else
          case text
          when /^([aiueo])/
            # TODO: 前の文字と母音が同じなら長音”ー”に置き換える

            char = CHAR_HASH[$1]
            # 行頭のみ捨て仮名を前に付与
            if is_head_of_word
              out << self.to_sutegana(char)
            end
            out << char
          when /^(nN)[^aiueo]/, /^(ja|ju|jo|hja|hju|hjo|bja|bju|bjo|pja|pju|pjo|mja|mju|mjo|rja|rju|rjo|wa|wi|we|kwa|kwi|kwe|gwa|gwi|gwe)/
            out << CHAR_HASH[$1]
          when /^((k|g|s|S|sj|z|Z|t|d|c|C|n|h|hw|p|b|bw|m|r)[aiueo])/
            out << CHAR_HASH[$1]
          when /^(hN)/
            out << CHAR_HASH[$1]
          when /^([nN])/
            out << CHAR_HASH[$1]
          when /^([-=、])/
            # TODO　ラ行動詞は=junは"いん"？
            out << CHAR_HASH[$1]
          when /^([qQ])[kCsStcmnp\]=]/
            out << CHAR_HASH[$1]
          when /^([qQ])$/
            out << CHAR_HASH[$1]
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
