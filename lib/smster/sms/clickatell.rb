class Sms::Clickatell < Sms
  def send_sms
    config = Smster.configuration
    authorization_code = config.clickatell_authorization_code

    text = self.text.tr(" ", "+")
    phone = to.gsub(/\D/, '') 

    api_message_id = if self.mode == 'test'
      logger.debug("Mode: #{mode}. To: #{phone}, text: #{text}")
      self.id
    else
      response = RestClient.post('https://api.clickatell.com/rest/message',
        { "text" => text, "to" => [phone.to_s] }.to_json, 
        :content_type => :json, 
        :accept => :json, 
        'X-Version' => 1, 
        'Authorization' => "bearer #{authorization_code}")
      JSON.parse(response)['data']['message'][0]['apiMessageId']
    end

    if api_message_id.present?
      self.code = api_message_id
      self.status = STATUS_CODES[:sent]
      self.save
    end
  rescue => e
    logger.debug("Error #{e}")
    self.status = STATUS_CODES[:failed]
    self.status_message = e.to_s
    self.save
  end
end