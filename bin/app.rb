#!/usr/bin/env ruby

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
  NUM_CARS = 2
  END_TIME = 11

  def initialize
    @cars = []
    (1..NUM_CARS).each do |id|
      new_car = Car.new(get_details(id))
      @cars.push(new_car) if not_exists(new_car)
    end
    # @cars.push(Car.new(id: 11, starting: 1, will_turn: false, time: 2))
    # @cars.push(Car.new(id: 44, starting: 1, will_turn: false, time: 1))
    @cars = @cars.sort_by(&:time)
  end

  def start
    (0..END_TIME).each do |time|
      puts "TIME #{time}"
      @cars.each do |car|
        puts "CAR #{car}: #{car.position_at(time)}"
        car.move(@cars, time)
        if INTERSECTION.include?(car.position)
          reservation = Hub.reserve(car)
          if reservation
            car.position_vector.concat(reservation)
          end
        end
      end
    end
  end

  private

  def get_details(id)
    {
      id: id,
      starting:  Random.rand(1..8),
      will_turn:  Random.rand(2).odd?,
      time:  Random.rand(6)
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