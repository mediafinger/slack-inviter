# frozen_string_literal: true

class Config
  SLACK_TEAM_NAME = "Ruby Web Devs"
  SLACK_TEAM_URL = "https://rubywebdev.slack.com"
  # generate your API token at https://api.slack.com/
  SLACK_TEAM_TOKEN = ENV["SLACK_TEAM_RUBYWEBDEV_API_TOKEN"]
end
