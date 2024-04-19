# frozen_string_literal: false

require 'minitest/autorun'
require_relative './body_converter'

class BodyConverterTest < Minitest::Test
  def test_case
    described_class = ::Converters::BodyConverter

    [
      ['泡。あーぶくともいう。～ぬたちゅん。泡が立つ。', '泡。?aabukuともいう。～nutacuN.泡が立つ。'],
      ['英語の-selfに似ている。わんくる（わたし自身で）', '英語の-selfに似ている。\'waNkuru（わたし自身で）'],
    ].each do |line|
      assert_equal described_class.convert_body(line[1]), line[0]
    end
  end
end
