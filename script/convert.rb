require 'csv'
require 'pp'
require_relative './converters/pronounce_to_kana.rb'

CSV.read('data/okinawa.csv', headers: true).each do |row|
  pp row['見出し語']
  pp ::Converters::PronounceToKana.convert(row['見出し語'])
end
