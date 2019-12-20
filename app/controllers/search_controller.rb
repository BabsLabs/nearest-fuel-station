require "uri"
require "net/http"

class SearchController < ApplicationController

  def index
    street = params[:location].split(',').first
    postal_code =  params[:location].split(',').last.tr('^0-9', '')
    state = params[:location].split(',').last.tr("0-9", "").gsub!(/\s+/, '')

    url = URI("https://developer.nrel.gov/api/alt-fuel-stations/v1.json?fuel_type=ELEC&limit=1&api_key=#{ENV['NREL_KEY']}&format=JSON&state=#{state}&street=#{street}&postal code=#{postal_code}")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)

    closest_station_results = JSON.parse(response.body, symbolize_names: :true)
  end

end