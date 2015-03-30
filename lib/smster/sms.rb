class Sms < ActiveRecord::Base
  self.table_name = "smsters"
  attr_accessor :mode

  ## Codes
  STATUS_CODES = { created: 0, sent: 1, delivered: 2, failed: 3 }

  ## Callbacks
  after_create :send_sms

  ## Etc.
  def initialize(attributes = {})
    attr_with_defaults = {
      status: STATUS_CODES[:created]
    }.merge(attributes)
    super(attr_with_defaults)
  end

  def mode
    @mode ||= case Rails.env
    when 'test' then 'test'
    else 'production'
    end
  end

  def reform_phone(number)
    number.gsub(/\D/, '') 
  end

  def accept!
    self.update(status: STATUS_CODES[:delivered])
  end
end