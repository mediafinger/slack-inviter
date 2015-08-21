require_relative './test_helper.rb'

class GetIndexTest < Minitest::Test
  def test_get_invite_is_success
    get '/invite'

    assert last_response.ok?
  end

  def test_get_invite_includes_the_form
    get '/invite'

    assert_includes last_response.body, "<form action='/invite' method='post'>"
    assert_includes last_response.body, "<input name='first_name' type='text'>"
    assert_includes last_response.body, "<input name='email' type='email'>"
    assert_includes last_response.body, "<input type='submit'>"
  end

  def test_get_invite_mentions_the_channel_name
    get '/invite'

    assert_includes last_response.body, Config::SLACK_TEAM_NAME
  end
end
