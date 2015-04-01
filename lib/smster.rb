require 'rest_client'
require "smster/configuration"
require 'smster/sms'
require 'smster/sms/clickatell'
require 'smster/sms/nexmo'
require 'smster/sms/smsru'

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
