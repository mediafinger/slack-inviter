require 'dotenv'
Dotenv.load

class Config
  SLACK_TEAM_NAME  = ENV["SLACK_TEAM_NAME"]
  SLACK_TEAM_URL   = ENV["SLACK_TEAM_URL"]
  SLACK_TEAM_TOKEN = ENV["SLACK_TEAM_TOKEN"]
end
