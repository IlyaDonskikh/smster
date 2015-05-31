require 'test_helper'

class SmsterTest < ActiveSupport::TestCase
  test 'confirguration' do
    nexmo_key = '123'

    Smster.configure do |config|
      config.nexmo_key = nexmo_key
    end

    config = Smster.configuration

    assert_equal nexmo_key, config.nexmo_key
  end
end
