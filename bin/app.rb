require_relative '../lib/hub.rb'
require_relative '../lib/car.rb'

## Main app that spawns cars and creates the intersection hub
class App
  attr_accessor :cars, :hub
  INTERSECTION = [
    [3, 4], [3, 5], [3, 6], [3, 7],
    [8, 4], [8, 5], [8, 6], [8, 7],
    [4, 3], [5, 3], [6, 3], [7, 3],
    [4, 8], [5, 8], [6, 8], [7, 8]
  ].freeze

  def initialize
    @cars = []

    (1..2).each do |id|
      new_car = Car.new(get_details(id))
      @cars.push(new_car) if not_exists(new_car)
    end
  end

  def start
    (1..11).each do |time|
      @cars.each do |car|
        car.check_front(@cars, time)
        if INTERSECTION.include?(car.position)
          reservation = Hub.reserve(car)
          if reservation
            car.position_vector.concat(reservation)
          end
        end
      end
      puts '============'
      puts @cars
      puts '============'
    end
  end

  private

  def get_details(id)
    {
      id: id,
      starting:  Random.rand(1..8),
      will_turn:  Random.rand(2).odd?,
      time:  Random.rand(1..7)
    }
  end

  def not_exists(new_car)
    @cars.select do |car|
      car.starting == new_car.starting && car.time == new_car.time
    end.empty?
  end
end

app = App.new
app.start