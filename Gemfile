# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# heroku expects the Ruby version in the Gemfile
ruby File.read("./.ruby-version").chop

gem "chimera_http_client",  "~> 1.4"
gem "puma",                 "~> 5.0"
gem "rake",                 "> 13.0"
gem "sinatra",              "~> 2.0"

group :test do
  gem "minitest"
  gem "rack-test", "~> 1.0" # github: "mediafinger/rack-test" # for Ruby 3.0 compatibility
end
