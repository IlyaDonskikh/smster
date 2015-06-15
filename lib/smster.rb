require 'rest_client'
require 'smster'
require 'smster/configuration'
require 'smster/sms'
require 'smster/sms/smsru'
require 'smster/sms/nexmo'
require 'smster/sms/clickatell'

module Smster
  class Engine < Rails::Engine; end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
