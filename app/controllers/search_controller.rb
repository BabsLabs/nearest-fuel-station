require "uri"
require "net/http"

class SearchController < ApplicationController

  def show
    nearest_station_search
  end

  private

  def nearest_station_search
    # I could not figure how to search by location without splitting up the params as seen below!
    # Also I way prefer NET HTTP to Faraday so I hope thats alright...
    street = params[:location].split(',').first
    postal_code =  params[:location].split(',').last.tr('^0-9', '')
    state = params[:location].split(',').last.tr("0-9", "").gsub!(/\s+/, '')

    url = URI("https://developer.nrel.gov/api/alt-fuel-stations/v1.json?fuel_type=ELEC&limit=1&format=JSON&state=#{state}&street=#{street}&postal code=#{postal_code}")

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-Api-Key"] = ENV["NREL_KEY"]

    closest_station_results = JSON.parse(https.request(request).body, symbolize_names: :true)

    @station = closest_station_results[:fuel_stations][0]
  end

end