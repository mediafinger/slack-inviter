# frozen_string_literal: true

class Inviter
  def initialize(url:, token:)
    @url = url
    @token = token
  end

  def invite(email, first_name, options = {})
    return { success: false, message: "We need your email address!" } if email.nil? || email.empty?
    return { success: false, message: "Please tell us your name." }   if first_name.nil? || first_name.empty?

    result = post_request(email: email, first_name: first_name, options: options)

    if result[:success]
      { success: true, message: "Done for <b>#{email}</b> - check your emails now!" }
    else
      { success: false, message: "That did not work, please try again!</br>#{result[:error]}" }
    end
  end

  private

  def post_request(email:, first_name:, options:)
    endpoint = "users.admin.invite"
    response = connection.post(endpoint, body: post_params(email, first_name, options))
    hash = response.parsed_body

    # The Slack API returns {"ok"=>true} if everything worked
    # and {"ok"=>false, "error"=>"some_reason"} if an error occured
    { success: hash["ok"], error: hash["error"] }
  end

  def connection
    ChimeraHttpClient::Connection.new(base_url: "#{@url}/api/")
  end

  def post_params(email, first_name, options)
    {
      email: email,
      first_name: first_name,
      token: @token,
      set_active: true,
      options: options,
    }
  end
end
