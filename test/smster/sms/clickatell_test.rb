require 'test_helper'

class Sms::ClickatellTest < ActiveSupport::TestCase
  def setup
    @provider = Sms::Clickatell

    @to = (99_999_999 * rand).to_i.to_s
    @text = 'i am rails smster!'

    stub_send_request
  end

  test 'create' do
    sms = @provider.create(text: @text, to: @to)

    assert_equal false, sms.new_record?
  end

  private

    def stub_send_request
      body = { data: { message: ['apiMessageId' => 15] } }.to_json

      stub_request(:post, 'https://api.clickatell.com/rest/message')
        .to_return(status: 200, body: body, headers: {})
    end
end
