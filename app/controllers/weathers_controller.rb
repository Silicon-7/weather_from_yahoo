class WeathersController < ApplicationController
  def index
    city = params[:city] || "Chicago"
    state = params[:state] || "IL"

    @weathers = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{ city }%2C%20#{ state }%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
    @channel = @weathers["query"]["results"]["channel"]

    @temp = @channel["item"]["condition"]["temp"]
    @temp_units = @channel["units"]["temperature"]
    @condition = @channel["item"]["condition"]["text"]

    @city = @channel["location"]["city"]
    @state = @channel["location"]["region"]

    @forecasts = @channel["item"]["forecast"].first(5)
  end
end
