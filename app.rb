require 'sinatra'
require 'haml'
require 'json'
require 'rest-client'

configure { set :server, :puma }
