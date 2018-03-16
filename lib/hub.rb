require_relative 'car.rb'
## Hub will make sure the cars get assigned the correct paths
class Hub
  attr_accessor :path, :cars

  def initialize
    @cars = []
    (1..10).each do |id|
      new_car = Car.new(get_details(id))
      @cars.push(new_car) if not_exists(new_car)
    end
  end

  private

  def get_details(id)
    {
      id: id,
      starting:  Random.rand(1..8),
      will_turn:  Random.rand(2).odd?,
      time:  Random.rand(3)
    }
  end

  def not_exists(new_car)
    @cars.select do |car|
      car.starting == new_car.starting && car.time == new_car.time
    end.empty?
  end
end
