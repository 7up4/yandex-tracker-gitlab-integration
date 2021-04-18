source "https://rubygems.org"
ruby "2.7.2"

gem "rake"
gem "hanami", "~> 1.3"
gem "puma", "~> 4.3"
gem "faraday"
gem "faraday_middleware"

gem "dotenv"
gem "sidekiq", "~> 5.2"
gem "activesupport", "~> 6.0"

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem "capistrano", "~> 3.11", require: false
  gem "capistrano-hanami", require: false
  gem "capistrano-sidekiq"
  gem "capistrano3-puma"
  gem "capistrano-rbenv"
  gem "hanami-webconsole"
  gem "shotgun", platforms: :ruby
end

group :test do
  gem "rspec"
end

group :production do
  # gem "puma"
end
