require 'test_helper'

class Smster::SmsruControllerTest < ActionController::TestCase
  def setup
    @text = "simple text"
    @number = (0...7).map { (1..9).to_a.sample }.join  
    @provider = Sms::Smsru
  end

  test 'callback' do
    delivered_code = Sms::STATUS_CODES[:delivered]
    sms = @provider.create(text: @text, to: @number)

    post :callback, { 
      "data" =>  ["sms_status\n#{sms.code}\n100"]
    }

    response = @response.status
    sms = assigns(:sms)
    assert_equal 100, @response.status
    assert_equal delivered_code, sms.status
  end
end