# frozen_string_literal: true

class Inviter
  def initialize(url:, token:)
    @url = url
    @token = token
  end

  def invite(email, first_name, options = {})
    return { success: false, message: "We need your email address!" } if email.nil? || email.empty?
    return { success: false, message: "Please tell us your name." }   if first_name.nil? || first_name.empty?

    result = post_request(email, first_name, options)

    if result[:success]
      { success: true, message: "Done for <b>#{email}</b> - check your emails now!" }
    else
      { success: false, message: "That did not work, please try again!</br>#{result[:error]}" }
    end
  end

  private

  def post_request(email, first_name, _options)
    api_result = RestClient.post(full_url, post_params(email, first_name))
    hash = JSON.parse(api_result)

    # The Slack API returns {"ok"=>true} if everything worked
    # and {"ok"=>false, "error"=>"some_reason"} if an error occured
    { success: hash["ok"], error: hash["error"] }
  end

  def full_url
    "#{@url}/api/users.admin.invite"
  end

  def post_params(email, first_name)
    {
      email: email,
      first_name: first_name,
      token: @token,
      set_active: true,
    }
  end
end
