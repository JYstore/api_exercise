namespace :dev do
  task :fetch_city => :environment do
    puts "Fetch city data..."
    response = RestClient.get "http://apis.juhe.cn/simpleWeather/cityList", :params => { :key => "a19bd23f1b5590165b4874706fb0217c" }
    data = JSON.parse(response.body)

    data["result"].each do |c|
      existing_city = City.find_by_juhe_id( c["id"] )
      if existing_city.nil?
        City.create!( :juhe_id => c["id"], :province => c["province"],
                      :city => c["city"], :district => c["district"] )
      end
    end

    puts "Total: #{City.count} cities"
  end
end
