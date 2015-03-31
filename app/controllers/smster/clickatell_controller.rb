class Smster::ClickatellController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def callback
    code = clickatell_params[:apiMessageId]
    description = clickatell_params[:description]
    sms = Sms::Clickatell.find_by!(code: code)

    sms.status_message = description
    sms.save

    sms.accept! if description == 'Received by recipient'
    result = { sms.id => sms.status }

    render json: result.as_json, status: 200
  end

  private
    def clickatell_params
      params.require(:data)
    end
end