# frozen_string_literal: true

ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../app"

include Rack::Test::Methods # rubocop:disable Style/MixinUsage

def app
  Sinatra::Application
end
