Rails.application.routes.draw do
  post 'smster/clickatell/callback'
  post 'smster/nexmo/callback'
  post 'smster/smsru/callback'
end
