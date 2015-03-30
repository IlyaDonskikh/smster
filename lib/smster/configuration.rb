module Smster
  class Configuration
    attr_accessor :nexmo_key, :nexmo_sekret, :clickatell_authorization_code

    def initialize
      @nexmo_key = ""
      @nexmo_sekret = ""
      @clickatell_authorization_code = ""
    end
  end
end