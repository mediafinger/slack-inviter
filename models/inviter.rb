class Inviter
  def initialize(url:, token:)
    @url = url
    @token = token
  end

  def invite(email)
    return false if email.nil? || email.empty?

    post_request(email)
  end

  private

  def post_request(email)
    api_result = RestClient.post(full_url, post_params(email))
    hash = JSON.parse(api_result)

    # The Slack API returns {"ok"=>true} if everything worked
    if hash["ok"]
      true
    else
      false
    end
  end

  def full_url
    "#{@url}/api/users.admin.invite"
  end

  def post_params(email)
    {
      email: email,
      token: @token,
      set_active: true
    }
  end
end
