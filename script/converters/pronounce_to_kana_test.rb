require 'minitest/autorun'
require_relative './pronounce_to_kana.rb'

class PronounceToKanaTest < Minitest::Test

  def test_case
    described_class = ::Converters::PronounceToKana

    [
      ['?aa', 'ああ'],
      ['?aka', 'あか'],
    ].each do |line|
      pronounce = line[0]
      kana = line[1]

      assert_equal kana, described_class.convert(pronounce)
    end
  end
end
