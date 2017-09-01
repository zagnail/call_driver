source 'https://rubygems.org'
ruby "2.4.0"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.5'
gem 'pg', '0.21.0'
gem 'puma', '~> 3.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'bcrypt', '~> 3.1.7'
gem 'doorkeeper'
gem 'jsonapi-resources'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'rack-cors'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.6'
  gem 'factory_girl_rails'
  gem 'rspec_api_documentation', '5.0.0'
  gem 'apitome'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
end

group :production do
  gem 'rails_12factor'
end
