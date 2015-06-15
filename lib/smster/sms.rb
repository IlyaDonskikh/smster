class Sms < ActiveRecord::Base
  self.table_name = 'smsters'

  attr_accessor :from, :api_message_id

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

  def send_sms
    send_to_provider

    status_name = api_message_id ? :sent : :failed
    self.status = STATUSES[status_name]

    self
  end

  def accept!
    update(status: STATUSES[:delivered])
  end

  def assing_code
    self.code = api_message_id
  end

  private

    def send_to_provider
      modify_params

      response = send_request
      assign_attrs_by(response)
    end
end
