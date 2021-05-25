# frozen_string_literal: true

require "sinatra"
require "haml"
require "json"
require "rest-client"

require_relative "config"
require_relative "models/inviter"
require_relative "models/dummy_inviter" # for tests or development

configure { set :server, :puma }

get "/" do
  haml :index
end

get "/invite" do
  haml :invite, locals: team_params
end

post "/invite" do
  @inviter ||= inviter
  result = @inviter.invite(params["email"], params["first_name"], test_result: params["test_result"])

  if result[:success]
    haml :invite, locals: { success: result[:message] }.merge!(team_params)
  else
    haml :invite, locals: { failure: result[:message] }.merge!(team_params)
  end
end

# use the class DummyInviter to not contact the API
def inviter
  klass = Inviter
  klass = DummyInviter if ENV["RACK_ENV"] == "test" # || 'development'

  klass.new(url: Config::SLACK_TEAM_URL, token: Config::SLACK_TEAM_TOKEN)
end

def team_params
  { team_name: Config::SLACK_TEAM_NAME, team_url: Config::SLACK_TEAM_URL }
end
