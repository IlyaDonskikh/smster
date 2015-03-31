require 'test_helper'

class Sms::NexmoTest < ActiveSupport::TestCase
  def setup
    @text = "simple text"
    @number = (0...7).map { (1..9).to_a.sample }.join  
    @provider = Sms::Nexmo
  end

  test "create" do
    sms = @provider.create(text: @text, to: @number)

    assert_equal false, sms.new_record?
  end

  test "format to" do
    to = "+#{@number}"
    sms = @provider.create(text: @text, to: to)

    assert_equal to, sms.to
  end
end