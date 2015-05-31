require 'test_helper'

class Smster::ClickatellControllerTest < ActionController::TestCase
  def setup
    @text = 'simple text'
    @number = (9_999_999 * rand).to_i
    @provider = Sms::Clickatell
  end

  test 'callback' do
    delivered_code = Sms::STATUS_CODES[:delivered]
    sms = @provider.create(text: @text, to: @number)

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
end
