# frozen_string_literal: true

require 'csv'
require 'rake/testtask'

require_relative './script/converter'

DESTINSTION_FILE = 'public/data/okinawa2.csv'

namespace :convert do
  desc 'かなを付与したCSVファイルを生成します'
  task :csv, [:dry, :rows] do |_, args|
    dry = args.dry.to_s != ''
    rows = args.rows.to_i

    if dry
      puts '実際に書き込みは行わずに結果をプレビューします'
    end

    csv_data = Converter.convert(rows:)

    if dry
      puts csv_data
    else
      File.write(DESTINSTION_FILE, csv_data)
      puts "ファイルに書き込みました #{DESTINSTION_FILE}"
    end
  end
end

Rake::TestTask.new do |test|
  test.test_files = Dir['script/**/*_test.rb']
  test.verbose = true
end
