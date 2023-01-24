class ApplicationController < ActionController::Base
  require 'finnhub_ruby'

  FinnhubRuby.configure do |config|
    config.api_key['api_key'] = Rails.application.credentials.dig(:finnhub, :api_key)
  end

  def finnhub_client
    FinnhubRuby::DefaultApi.new
  end

  def get_last_price(holding)
    Rails.cache.fetch("#{holding.id}", expires_in: 30.seconds) do
      begin
        finnhub_client.quote(holding.symbol).c
      rescue FinnhubRuby::ApiError
        '-'
      end
    end
  end
  helper_method :get_last_price
end
