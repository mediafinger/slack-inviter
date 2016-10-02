require_relative "./test_helper.rb"

class PostInviteTest < Minitest::Test
  def setup
    @email  = "andy@finger.com"
    @params = { email: @email, first_name: "Andy" }
  end

  def test_post_invite_is_success
    post '/invite', @params

    assert last_response.ok?
  end

  def test_post_invite_includes_the_form
    post '/invite', @params

    assert_includes last_response.body, "<form action='/invite' class='form-inline' method='post'>"
    assert_includes last_response.body, "<input class='form-control' id='first_name' name='first_name' type='text'>"
    assert_includes last_response.body, "<input class='form-control' id='email' name='email' type='email'>"
    assert_includes last_response.body, "<input class='btn btn-lg btn-success btn-default' type='submit'>"
  end

  def test_post_invite_mentions_the_channel_name
    post '/invite', @params

    assert_includes last_response.body, Config::SLACK_TEAM_NAME
  end

  def test_post_invite_includes_failure_message
    post '/invite', @params

    assert_includes last_response.body, "<div class='alert alert-danger'>"
    assert_includes last_response.body, "That did not work, please try again!</br>some_reason"
  end

  def test_post_invite_includes_success_message
    post '/invite', @params.merge(test_result: true)

    assert_includes last_response.body, "<div class='alert alert-success'>"
    assert_includes last_response.body, "Done for <b>#{@email}</b> - check your emails now!"
  end

  def test_post_invite_initializes_inviter
    post '/invite', @params.merge(test_result: true)

    parameters = [url: Config::SLACK_TEAM_URL, token: Config::SLACK_TEAM_TOKEN]

    obj = DummyInviter.new
    assert_send([obj, :invite, *parameters])
  end

  def test_post_invite_initializes_inviter
    post '/invite', @params.merge(test_result: true)

    parameters = [url: Config::SLACK_TEAM_URL, token: Config::SLACK_TEAM_TOKEN]

    assert_send([DummyInviter, :new, *parameters])
  end
end
