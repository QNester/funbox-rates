source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# -- Core -- #
gem 'rails', '~> 5.1.3'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'
gem 'foreman'
gem 'oj'

# -- Frontend -- #
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'autoprefixer-rails'
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'

# -- Dev & Test -- #
group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'factory_girl_rails'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

# -- Dev -- #
group :development do
  gem 'rubocop'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
