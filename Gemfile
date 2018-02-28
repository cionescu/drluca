source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.9.1'

gem 'sprockets', '>= 3.0.0'
gem 'sprockets-es6'
gem 'redis', '~> 3.0'
gem 'factory_girl_rails'
gem 'annotate'
gem 'hamlit'
gem 'morpheus-heroku', '0.3.1'
gem 'sidekiq'
gem 'active_model_serializers', '~> 0.10.0'
gem 'devise'
gem 'webpacker', '~> 2.0'
gem 'sentry-raven'
gem 'pg_search'

# Assets
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'uglifier', '>= 1.3.0'
gem 'sassc-rails'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'jquery-rails'
gem 'sweetalert-rails'
gem 'font-awesome-rails'
gem 'popper_js', '~> 1.12.9'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'simplecov'
  gem 'rspec-rails', '~> 3.4'
  gem 'pry-rails'
  gem 'ffaker'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.1.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring-commands-rspec'
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
end
