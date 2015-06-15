require 'test_helper'

class Smster::ClickatellControllerTest < ActionController::TestCase
  def setup
    @provider = Sms::Clickatell

    super
  end

  test 'callback' do
    delivered_code = Sms::STATUSES[:delivered]
    sms = @provider.create(text: @text, to: @to)

    post :callback, 'data' =>  {
      'charge' => 1.5,
      'messageStatus' => 003,
      'description' => 'Received by recipient',
      'apiMessageId' => sms.code
    }

    response = JSON.parse(@response.body)
    result = { sms.id => delivered_code }
    assert_equal result.as_json, response
  end

  private

    def stub_send_request
      body = { data: { message: ['apiMessageId' => 15] } }.to_json

      stub_request(:post, 'https://api.clickatell.com/rest/message')
        .to_return(status: 200, body: body, headers: {})
    end
end
