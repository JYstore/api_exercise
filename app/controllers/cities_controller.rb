class CitiesController < ApplicationController

  def index
    @cities = City.all
  end

  def update_temp
      city = City.find(params[:id])

      response = RestClient.get "http://apis.juhe.cn/simpleWeather/query",
                                :params => { :cityname => city.juhe_id, :key => "a19bd23f1b5590165b4874706fb0217c" }
      data = JSON.parse(response.body)

      city.update( :current_temp => data["result"]["temperature"] )

      redirect_to cities_path
  end

end
