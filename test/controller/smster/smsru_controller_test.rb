require 'test_helper'

class Smster::SmsruControllerTest < ActionController::TestCase
  def setup
    @text = 'simple text'
    @number = (9_999_999 * rand).to_i
    @provider = Sms::Smsru
  end

  test 'callback' do
    delivered_code = Sms::STATUS_CODES[:delivered]
    sms = @provider.create(text: @text, to: @number)

    post :callback, 'data' =>  ["sms_status\n#{sms.code}\n100"]

    sms = assigns(:sms)
    assert_equal 100, @response.status
    assert_equal delivered_code, sms.status
  end
end
