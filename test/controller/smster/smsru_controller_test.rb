require 'test_helper'

class Smster::SmsruControllerTest < ActionController::TestCase
  def setup
    @provider = Sms::Smsru

    stub_cost_smsru_request

    super
  end

  test 'callback' do
    delivered_code = Sms::STATUSES[:delivered]
    sms = @provider.create(text: @text, to: @to)

    post :callback, 'data' =>  ["sms_status\n#{sms.code}\n100"]

    sms = assigns(:sms)
    assert_equal 100, @response.status
    assert_equal delivered_code, sms.status
  end

  private

    def stub_send_request
      body = "100\n201523-1000007\nbalance=52.54"

      stub_request(:post, 'http://sms.ru/sms/send')
        .to_return(status: 200, body: body, headers: {})
    end
end
