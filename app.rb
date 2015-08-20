require 'sinatra'
require 'haml'
require 'json'
require 'rest-client'

require_relative 'config.rb'
require_relative 'models/inviter.rb'
require_relative 'models/dummy_inviter.rb' # for tests or development

configure { set :server, :puma }

get '/' do
  haml :index
end

get '/invite' do
  haml :invite, locals: { slack_channel_name: Config::SLACK_CHANNEL_NAME }
end

post '/invite' do
  @inviter ||= inviter
  result = @inviter.invite(params['email'], params['first_name'], test_result: params['test_result'])

  if result[:success]
    haml :invite, locals: { success: result[:message], slack_channel_name: Config::SLACK_CHANNEL_NAME }
  else
    haml :invite, locals: { failure: result[:message], slack_channel_name: Config::SLACK_CHANNEL_NAME }
  end
end

# use the class DummyInviter to not contact the API
def inviter
  klass = Inviter
  klass = DummyInviter if ENV['RACK_ENV'] == 'test' # || 'development'

  klass.new(url: Config::SLACK_CHANNEL_URL, token: Config::SLACK_CHANNEL_TOKEN)
end
