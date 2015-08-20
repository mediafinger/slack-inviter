# Slack Invitation app

When you administer a free Slack group, you might know this issue: copying and pasting emails to invite new members is quite cumbersome. It would be so much easier, if they could just fill in their email into a form, hit the submit button and receive an invite from Slack automatically... BINGO! That's exactly what this little Ruby / Sinatra app is doing :-)

_Let people invite themselves to your Slack group with this very simple Ruby / Sinatra app_

## Setup

If you want to use this app for your own Slack group, you just have to change the contents of `Config.rb` to match your information.
You can get the Slack API key for your group at https://api.slack.com/

## Development

- [ ] Fork and clone the github repository or just run `git clone git@github.com:mediafinger/slack-inviter.git`
- [ ] Check that you have a compatible Ruby version installed. At the moment the `.ruby-version` file sets it to `2.2.3`
- [ ] run `bundle install`
- [ ] no database needed :-)
- [ ] either ensure that in `app.rb` the `DummyInviter` is instantiated - to not send API calls through the real `Inviter` class
- [ ] or update the information in `config.rb` - obviously the API key should be set as an ENV variable
- [ ] run the server `bundle exec ruby app.rb`
- [ ] open the website at **http://localhost:4567/**

If you make it look nicer, than pretty-please send me a pull request :-)

## Testing

Just run `rake test` to run all the tests.

## Deployment

TODO

If you use the app, please star it on GitHub and/or let me know you are doing it. Don't worry, it is for free, no strings attached.
