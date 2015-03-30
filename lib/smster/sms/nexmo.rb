class Sms::Nexmo < Sms
  def send_sms
    config = Smster.configuration
    api_key = config.nexmo_key
    api_secret = config.nexmo_sekret

    text = self.text.tr(" ", "+")
    phone = to.gsub(/\D/, '') 
    current_status = STATUS_CODES[:sent]

    api_message_id = if self.mode == 'test'
      puts "Mode: #{mode}. To: #{phone}, text: #{text}"
      self.id
    else
      response = RestClient.post('https://rest.nexmo.com/sms/json', 
        "text" => text, 
        "to" => phone.to_s, 
        :content_type => :json,
        :from => 'OnlinePay',
        :api_key => api_key,
        :api_secret => api_secret)
      JSON.parse(response)['messages'][0]['message-id']
    end

    if api_message_id.present?
      self.code = api_message_id
      self.status = STATUS_CODES[:sent]
      self.save
    end
  rescue => e
    puts 'Error: ' + e.to_s
    self.status = STATUS_CODES[:failed]
    self.status_message = e.to_s
    self.save
  end
end