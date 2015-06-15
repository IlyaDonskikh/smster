require 'test_helper'

class Smster::NexmoControllerTest < ActionController::TestCase
  def setup
    @provider = Sms::Nexmo

    super
  end

  test 'callback' do
    delivered_code = Sms::STATUSES[:delivered]
    sms = @provider.create(text: @text, to: @number)

    post :callback, 'messageId' => sms.code, 'status' => 'delivered'

    response = JSON.parse(@response.body)
    result = { sms.id => delivered_code }

    assert_equal result.as_json, response
  end

  private

    def stub_send_request
      body = { messages: ['message-id' => 15] }.to_json

      stub_request(:post, 'https://rest.nexmo.com/sms/json')
        .to_return(status: 200, body: body, headers: {})
    end
end
