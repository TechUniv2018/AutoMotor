require_relative 'car.rb'
## Hub will make sure the cars get assigned the correct paths
class Hub
  attr_accessor :intersection

  def self.reserve(car)
    car.turn = true if car.will_turn
    time = car.position_vector.last[:time]
    case car.position
    when [3, 4]
      [{ x: 4, y: 4, time: time + 1 }]
    when [3, 5]
      [
        { x: 4, y: 5, time: time + 1 },
        { x: 5, y: 5, time: time + 2 },
        { x: 6, y: 5, time: time + 3 },
        { x: 6, y: 6, time: time + 4 },
        { x: 6, y: 7, time: time + 5 }
      ]
    when [8, 6]
      [
        { x: 7, y: 6, time: time + 1 },
        { x: 6, y: 6, time: time + 2 },
        { x: 5, y: 6, time: time + 3 },
        { x: 5, y: 5, time: time + 4 },
        { x: 5, y: 4, time: time + 5 }
      ]
    when [8, 7]
      [{ x: 7, y: 7, time: time + 1 }]
    when [6, 3]
      [
        { x: 6, y: 4, time: time + 1 },
        { x: 6, y: 5, time: time + 2 },
        { x: 6, y: 6, time: time + 3 },
        { x: 5, y: 6, time: time + 4 },
        { x: 4, y: 6, time: time + 5 }
      ]
    when [7, 3]
      [{ x: 7, y: 4, time: time + 1 }]
    when [4, 8]
      [{ x: 4, y: 7, time: time + 1 }]
    when [5, 8]
      [
        { x: 5, y: 7, time: time + 1 },
        { x: 5, y: 6, time: time + 2 },
        { x: 5, y: 5, time: time + 3 },
        { x: 6, y: 5, time: time + 4 },
        { x: 7, y: 5, time: time + 5 }
      ]
    end
  end
end
