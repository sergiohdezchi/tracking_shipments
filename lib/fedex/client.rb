# frozen_string_literal: true
require 'fedex'

class Fedex::Client
  def initialize
    @key = Rails.application.secrets.fedex[:key]
    @password = Rails.application.secrets.fedex[:password]
    @account_number = Rails.application.secrets.fedex[:account_number]
    @meter = Rails.application.secrets.fedex[:meter]
    @mode = Rails.application.secrets.fedex[:mode]
  end

  def connection
    ::Fedex::Shipment.new(
      key: @key,
      password: @password,
      account_number: @account_number,
      meter: @meter,
      mode: @mode
    )
  end
end
