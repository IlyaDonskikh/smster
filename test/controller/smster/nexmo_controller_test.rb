require 'test_helper'

class Smster::NexmoControllerTest < ActionController::TestCase
  def setup
    @text = "simple text"
    @number = (0...7).map { (1..9).to_a.sample }.join  
    @provider = Sms::Nexmo
  end

  test 'callback' do
    delivered_code = Sms::STATUS_CODES[:delivered]
    sms = @provider.create(text: @text, to: @number)

    post :callback, { "messageId" => sms.code, "status" => 'delivered' }
    response = JSON.parse(@response.body)
    result = { sms.id => delivered_code }
    assert_equal result.as_json, response
  end
end