class Sms < ActiveRecord::Base
  self.table_name = 'smsters'
  attr_accessor :mode

  ## Codes
  STATUS_CODES = { created: 0, sent: 1, delivered: 2, failed: 3 }

  ## Callbacks
  after_create :send_sms

  ## Validations
  validates :type, :to, :text, presence: true

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

  def accept!
    update(status: STATUS_CODES[:delivered])
  end
end
