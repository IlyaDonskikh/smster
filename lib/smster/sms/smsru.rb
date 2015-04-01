class Sms::Smsru < Sms
  def send_sms
    config = Smster.configuration
    api_id = config.smsru_api_id

    text = self.text.tr(" ", "+")
    phone = to.gsub(/\D/, '') 

    api_message_id = if self.mode == 'test'
      logger.debug("Mode: #{mode}. To: #{phone}, text: #{text}")
      self.id
    else
      response = RestClient.post('http://sms.ru/sms/send', 
        "api_id" => api_id, 
        "text" => text, 
        "to" => phone.to_s, 
        "from" => name
      )

      case response.include?('100')
      when true then result = (/\n(.*)\n/).match(response)[1]
      else raise response
      end

      result
    end

    if api_message_id.present?
      self.code = api_message_id
      self.status = STATUS_CODES[:sent]
    end

    self.save
  rescue => e
    logger.debug("Error #{e}")
    self.status = STATUS_CODES[:failed]
    self.status_message = e.to_s
    self.save
  end
end