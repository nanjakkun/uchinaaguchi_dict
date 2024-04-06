# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.2'

gem 'activesupport', '~> 7.1.3'

gem 'rake'

gem 'rubocop'
gem 'rubocop-minitest'
gem 'rubocop-performance'

# github-pages, Jekyll
group :jekyll_plugins do
  gem 'github-pages'
  gem 'jekyll-feed', '~> 0.12'

  # This is the default theme for new Jekyll sites. You may change this to anything you like.
  gem 'minima', '~> 2.5'

  gem 'webrick'
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
# and associated library.
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem 'tzinfo', '>= 1', '< 3'
  gem 'tzinfo-data'
end

# Performance-booster for watching directories on Windows
gem 'wdm', '~> 0.1.1', platforms: %i[mingw x64_mingw mswin]

# Lock `http_parser.rb` gem to `v0.6.x` on JRuby builds since newer versions of the gem
# do not have a Java counterpart.
gem 'http_parser.rb', '~> 0.6.0', platforms: [:jruby]
