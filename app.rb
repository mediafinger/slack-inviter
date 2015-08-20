require 'sinatra'
require 'haml'
require 'json'
require 'rest-client'

require_relative 'config.rb'
require_relative 'models/inviter.rb'

configure { set :server, :puma }

get '/' do
  haml :index
end

get '/invite' do
  haml :invite, locals: { slack_channel_name: Config::SLACK_CHANNEL_NAME }
end

post '/invite' do
  @inviter ||= Inviter.new(url: Config::SLACK_CHANNEL_URL, token: Config::SLACK_CHANNEL_TOKEN)
  result = @inviter.invite(email: params['email'], first_name: params['first_name'])

  if result[:success]
    haml :invite, locals: { success: result[:message], slack_channel_name: Config::SLACK_CHANNEL_NAME }
  else
    haml :invite, locals: { failure: result[:message], slack_channel_name: Config::SLACK_CHANNEL_NAME }
  end
end
