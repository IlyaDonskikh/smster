require 'test_helper'

class Sms::ClickatellTest < ActiveSupport::TestCase
  def setup
    @text = 'simple text'
    @number = (9_999_999 * rand).to_i
    @provider = Sms::Clickatell
  end

  test 'create' do
    sms = @provider.create(text: @text, to: @number)

    assert_equal false, sms.new_record?
  end

  test 'format to' do
    to = "+#{@number}"
    sms = @provider.create(text: @text, to: to)

    assert_equal to, sms.to
  end
end
