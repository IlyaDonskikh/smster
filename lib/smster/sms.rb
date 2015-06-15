class Sms < ActiveRecord::Base
  self.table_name = 'smsters'

  attr_accessor :from, :api_message_id, :balance, :cost

  ## Callbacks
  before_validation :assing_status

  ## Codes
  STATUSES = { created: 0, sent: 1, delivered: 2, failed: 3 }

  ## Etc.
  def self.create(attrs = {})
    sms = new(attrs).send_sms
    sms.assing_code
    sms.save

    sms
  end

  def assing_status
    self.status ||= STATUSES[:created]
  end

  def accept!
    update(status: STATUSES[:delivered])
  end

  def assing_code
    self.code = api_message_id
  end
end
