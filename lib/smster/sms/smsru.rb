class Sms::Smsru < Sms
  def send_sms
    api_message_id = send_to_provider

    if api_message_id.present?
      self.code = api_message_id
      self.status = STATUS_CODES[:sent]
    end

    save
  rescue => e
    process_rescue(e)
  end

  private

    def send_to_provider
      text = self.text.tr(' ', '+')
      phone = to.gsub(/\D/, '')

      result = id if mode == 'test'

      unless result
        response = send_request(text, phone)
        generate_send_resonse(response)
      end

      logger.debug("Mode: #{mode}. To: #{phone}, text: #{text}")

      result
    end

    def send_request(text, phone)
      config = Smster.configuration
      api_id = config.smsru_api_id

      RestClient.post(
        'http://sms.ru/sms/send',
        'api_id' => api_id,
        'text' => text,
        'to' => phone,
        'from' => name
      )
    end

    def generate_send_resonse(response)
      if response.include?('100')
        result = (/\n(.*)\n/).match(response)[1]
      else
        fail response
      end

      result
    end

    def process_rescue(e)
      logger.debug("Error #{e}")

      self.status = STATUS_CODES[:failed]
      self.status_message = e.to_s

      save
    end
end
