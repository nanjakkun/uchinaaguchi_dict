# frozen_string_literal: true

require 'minitest/autorun'
require_relative './pronounce_to_kana'

class PronounceToKanaTest < Minitest::Test
  def test_case
    described_class = ::Converters::PronounceToKana

    [
      ['あー', '?aa'],
      ['あか', '?aka'],
      ['ちばち', 'Cibaci', false],
      ['つぃばち', 'Cibaci', true],
      ['じゅり', 'Zuri', false],
      ['ずり', 'Zuri', true],
    ].each do |line|
      kana = line[0]
      pronounce = line[1]
      by_warrior = line.length > 2 && line[2]

      assert_equal described_class.convert(pronounce, by_warrior), kana
    end
  end
end
