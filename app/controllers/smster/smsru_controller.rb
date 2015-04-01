class Smster::SmsruController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback
    smsru_params.each do |data|
      data = data.split(/\n/)
      if data[0] == 'sms_status'
        code = data[1]
        status = data[2]
        @sms = Sms::Smsru.find_by!(code: code)

        @sms.status_message = status
        @sms.save

        @sms.accept! if status.to_s == '100'
      end
    end

    render nothing: true, status: 100
  end

  private
    def smsru_params
      params.require(:data)
    end
end