# Configure Rails Environment
ENV["RAILS_ENV"] = 'test'

require File.expand_path('../../test/dummy/config/environment.rb',  __FILE__)
ActiveRecord::Migrator.migrations_paths = [File.expand_path('../../test/dummy/db/migrate', __FILE__)]

require 'rails/test_help'
require 'webmock/minitest'

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load support files
Dir['#{File.dirname(__FILE__)}/support/**/*.rb'].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path('../fixtures', __FILE__)
  ActiveSupport::TestCase.fixtures :all
end

class ActiveSupport::TestCase
  def setup
    @to = (99_999_999 * rand).to_i.to_s
    @text = 'i am rails smster!'

    stub_send_request
  end

  def stub_send_request; end
end

def stub_cost_smsru_request
  body = "100\n0.69\n1"

  stub_request(:post, 'http://sms.ru/sms/cost')
    .to_return(status: 200, body: body, headers: {})
end