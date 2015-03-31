class Smster::NexmoController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback
    code = params['messageId']
    status = params['status']
    sms = Sms::Nexmo.find_by!(code: code)

    sms.status_message = status
    sms.save

    sms.accept! if status == 'delivered'
    result = { sms.id => sms.status }

    render json: result.as_json, status: 200
  end
end