class Sms::Clickatell < Sms
  def send_sms
    text = self.text.tr(" ", "+")
    phone = to.gsub(/\D/, '') 
    authorization_code = Rails.application.config.x.clickatell.authorization_code

    api_message_id = if self.mode == 'test'
      puts "Mode: #{mode}. To: #{phone}, text: #{text}"
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
    p 'Error: ' + e.to_s
    self.status = STATUS_CODES[:failed]
    self.save
  end
end