# Use this DummyInviter class in the tests
# or while you are developing and don't want to make any API calls

require_relative 'inviter.rb'

class DummyInviter < Inviter
  private

  # The Slack API returns {"ok"=>true} if everything worked
  # and {"ok"=>false, "error"=>"some_reason"} if an error occured
  def post_request(email, first_name, options)
    hash = { "ok" => options[:test_result] }
    hash.merge!("error" => "some_reason") unless options[:test_result]

    { success: hash["ok"], error: hash["error"] }
  end
end
