#!/usr/bin/env ruby

require_relative '../lib/hub.rb'
require_relative '../lib/car.rb'
require 'json'

## Main app that spawns cars and creates the intersection hub
class App
  attr_accessor :cars, :hub
  INTERSECTION = [
    [3, 4], [3, 5], [3, 6], [3, 7],
    [8, 4], [8, 5], [8, 6], [8, 7],
    [4, 3], [5, 3], [6, 3], [7, 3],
    [4, 8], [5, 8], [6, 8], [7, 8]
  ].freeze
  NUM_CARS = 12
  END_TIME = 12

  def initialize
    @cars = []
    (1..NUM_CARS).each do |id|
      new_car = Car.new(get_details(id))
      @cars.push(new_car) if not_exists(new_car)
    end
    # @cars.push(Car.new(id: 11, starting: 7, will_turn: true, time: 3))
    # @cars.push(Car.new(id: 22, starting: 1, will_turn: false, time: 4))
    # @cars.push(Car.new(id: 44, starting: 3, will_turn: false, time: 0))
    @cars = @cars.sort_by(&:time)
  end

  def start
    data = []
    (0..END_TIME).each do |time|
      time_data = { time: time, cars: [] }
      @cars.each do |car|
        time_data[:cars].push(id: car.id,
                              lane: car.starting,
                              turn: car.will_turn,
                              positon: car.position_at(time))
        car.move(@cars, time)
        if INTERSECTION.include?(car.position)
          reservation = Hub.reserve(car)
          car.position_vector.concat(reservation) if reservation
        end
      end
      data.push(time_data)
    end
    File.open('data.json', 'w') { |f| f.write(JSON.generate(data)) }
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
