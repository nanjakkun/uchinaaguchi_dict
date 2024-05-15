# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/color'
require_relative './pronounce_converter'

class PronounceConverterTest < Minitest::Test
  def test_case
    described_class = ::Converters::PronounceConverter

    [
      ['あー', '?aa', true],
      ['あー', '?aa', false],

      ['あか', '?aka', true],
      ['あか', '?aka', false],

      ['あぐなー', '?agunaa', true],
      ['あぐなー', '?agunaa', false],

      ['ふぃっばてぃ', 'hwiQPati', true],
      ['ふぃっばてぃ', 'hwiQPati', false],

      ['うとぅ', '?utu', true],
      ['うとぅ', '?utu', false],

      ['ぅうとぅ', "'utu", true],
      ['ぅうとぅ', "'utu", false],

      ['しゅん', 'sjun', true],
      ['すん', 'sjun', false],

      ['ずり', 'Zuri', true],
      ['じゅり', 'Zuri', false],

      ['つぃばち', 'Cibaci', true],
      ['ちばち', 'Cibaci', false],

      ['ちょんだらー', 'coNdaraa', true],
      ['ちょんだらー', 'coNdaraa', false],

      ['んーじゅん', "'NNzuN", true],
      ['んーじゅん', "'NNzuN", false],
    ].each do |line|
      kana = line[0]
      pronounce = line[1]
      by_warrior = line.length > 2 && line[2]

      assert_equal described_class.pronounce_to_kana(pronounce, by_warrior), kana
    end
  end
end
