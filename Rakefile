# frozen_string_literal: true

require 'csv'
require 'rake/testtask'

require_relative './script/converter'

namespace :convert do
  desc 'かなを付与したCSVファイルを生成します'
  task :csv, [:dry, :rows] do |_, args|
    dry = args.dry.to_s != ''
    rows = args.rows.to_i

    Converter.convert(dry:, rows:)
  end
end

Rake::TestTask.new do |test|
  test.test_files = Dir['script/**/*_test.rb']
  test.verbose = true
end
