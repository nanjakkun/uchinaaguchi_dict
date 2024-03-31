# frozen_string_literal: true

require 'csv'
require_relative './converters/pronounce_to_kana'

CSV.read('data/okinawa.csv', headers: true).each do |row|
  pp row['見出し語']

  # TODO　ラ行動詞は=junは"いん"と"ゆん"の見出し語を作る
  # TODO　士族の言葉も作る
  pp ::Converters::PronounceToKana.convert(row['見出し語'])
end
