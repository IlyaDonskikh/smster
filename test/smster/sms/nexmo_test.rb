require 'test_helper'

class Sms::NexmoTest < ActiveSupport::TestCase
  def setup
    @provider = Sms::Nexmo

    super
  end

  test 'create' do
    sms = @provider.create(text: @text, to: @to)

    assert_equal false, sms.new_record?
  end

  private

    def stub_send_request
      body = { messages: ['message-id' => 15] }.to_json

      stub_request(:post, 'https://rest.nexmo.com/sms/json')
        .to_return(status: 200, body: body, headers: {})
    end
end
