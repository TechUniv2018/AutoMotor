require_relative '../lib/hub.rb'

hub = Hub.new
hub.cars.each do |car|
  puts car
end
