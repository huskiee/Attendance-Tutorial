##12-2source 'https://rubygems.org'

##it_source(:github) do |repo_name|
  ##repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  ##"https://github.com/#{repo_name}.git"
##end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
##12-2gem 'rails', '~> 5.1.6'
## 8x.1 日本語、国際化
##12-2gem 'rails-i18n'
## 4.5 パスワードの設定を追加するgemです
##12-2gem 'bcrypt'
## 8.4 全てのユーザーを表示するページ
##12-2gem 'faker' # この行を追加してください。
# Use sqlite3 as the database for Active Record
##gem 'sqlite3'
# 3.2 Bootstrapの追加
##12-2gem 'bootstrap-sass'
## 8.4.2 ページネーションを使おう
##12-2gem 'will_paginate' # この行を追加してください。
##12-2gem 'bootstrap-will_paginate' # この行を追加してください。
# Use Puma as the app server
##12-2gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
##12-2gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
##12-2gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
##12-2gem 'coffee-rails', '~> 4.2'
#1.1 コード修正
##12-2gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
##12-2gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
##12-2gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

##12-2group :development, :test do
  #1.1 コード修正
  ##12-2gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  ##12-2gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  ##gem 'capybara', '~> 2.13'
  ##gem 'selenium-webdriver'
##12-2end

##12-2group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  ##12-2gem 'web-console', '>= 3.3.0'
  ##12-2gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  ##12-2gem 'spring'
  ##12-2gem 'spring-watcher-listen', '~> 2.0.0'
##12-2end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# Windows環境ではtzinfo-dataというgemを含める必要があります
# Mac環境でもこのままでOKです
##12-2gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

##【勤怠番外編2】Herokuを使ってデプロイしよう
source 'https://rubygems.org'

gem 'rails',        '~> 5.1.6'
gem 'rails-i18n'
gem 'bcrypt'
gem 'faker'
gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'puma',         '~> 3.7'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',   '~> 5'
gem 'jbuilder',     '~> 2.5'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
# Mac環境でもこのままでOKです
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]