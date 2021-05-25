# frozen_string_literal: true

source "https://rubygems.org"

# heroku expects the Ruby version in the Gemfile
ruby_version = File.read("./.ruby-version").chop || "2.7.3"
ruby ruby_version

gem "sinatra",      "~> 1.4"

gem "haml",         "~> 4.0"
gem "json",         "~> 2.0"
gem "puma",         "~> 4.0"
gem "rake",         "> 11.0"

# version 1.8 has much heavier dependencies:
# http-cookie -> domain_name -> unf -> C-extension...
gem "rest-client",  "~> 1.7.0"

group :test do
  gem "minitest"
  gem "rack-test"
end
