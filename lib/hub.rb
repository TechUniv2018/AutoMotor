require_relative 'car.rb'
## Hub will make sure the cars get assigned the correct paths
class Hub
  END_TIME = 20
  attr_accessor :intersection
  matrix = [
    { x: 4, y: 4, free: true }, { x: 4, y: 5, free: true },
    { x: 4, y: 6, free: true }, { x: 4, y: 7, free: true },
    { x: 5, y: 4, free: true }, { x: 5, y: 5, free: true },
    { x: 5, y: 6, free: true }, { x: 5, y: 7, free: true },
    { x: 6, y: 4, free: true }, { x: 6, y: 5, free: true },
    { x: 6, y: 6, free: true }, { x: 6, y: 7, free: true },
    { x: 7, y: 4, free: true }, { x: 7, y: 5, free: true },
    { x: 7, y: 6, free: true }, { x: 7, y: 7, free: true }
  ]

  @intersection = [{ time: 0, matrix: matrix }]
  (1..END_TIME).each do |t|
    @intersection.push(time: t, matrix: matrix)
  end

  def self.reserve(car)
    car.turn = true if car.will_turn
    time = car.position_vector.last[:time]
    case car.position
    when [3, 4]
      can_reserve = [check(x: 4, y: 4, time: time + 1)].all? { |x| !x.nil? }
      if can_reserve
        [{ x: 4, y: 4, time: time + 1 }]
      else
        [{ x: 3, y: 4, time: time + 1 }]
      end
    when [3, 5]
      can_reserve = [check(x: 4, y: 5, time: time + 1),
                     check(x: 5, y: 5, time: time + 2),
                     check(x: 6, y: 5, time: time + 3),
                     check(x: 6, y: 6, time: time + 4),
                     check(x: 6, y: 7, time: time + 5)].all? { |x| !x.nil? }
      if can_reserve
        [
          { x: 4, y: 5, time: time + 1 },
          { x: 5, y: 5, time: time + 2 },
          { x: 6, y: 5, time: time + 3 },
          { x: 6, y: 6, time: time + 4 },
          { x: 6, y: 7, time: time + 5 }
        ]
      else
        [{ x: 3, y: 5, time: time + 1 }]
      end
    when [8, 6]
      can_reserve = [check(x: 7, y: 6, time: time + 1),
                     check(x: 6, y: 6, time: time + 2),
                     check(x: 5, y: 6, time: time + 3),
                     check(x: 5, y: 5, time: time + 4),
                     check(x: 5, y: 4, time: time + 5)].all? { |x| !x.nil? }
      if can_reserve
        [
          { x: 7, y: 6, time: time + 1 },
          { x: 6, y: 6, time: time + 2 },
          { x: 5, y: 6, time: time + 3 },
          { x: 5, y: 5, time: time + 4 },
          { x: 5, y: 4, time: time + 5 }
        ]
      else
        [{ x: 8, y: 6, time: time + 1 }]
      end
    when [8, 7]
      can_reserve = [check(x: 7, y: 7, time: time + 1)].all? { |x| !x.nil? }
      if can_reserve
        [{ x: 7, y: 7, time: time + 1 }]
      else
        [{ x: 8, y: 7, time: time + 1 }]
      end
    when [6, 3]
      can_reserve = [check(x: 6, y: 4, time: time + 1),
                     check(x: 6, y: 5, time: time + 2),
                     check(x: 6, y: 6, time: time + 3),
                     check(x: 5, y: 6, time: time + 4),
                     check(x: 4, y: 6, time: time + 5)].all? { |x| !x.nil? }
      if can_reserve
        [
          { x: 6, y: 4, time: time + 1 },
          { x: 6, y: 5, time: time + 2 },
          { x: 6, y: 6, time: time + 3 },
          { x: 5, y: 6, time: time + 4 },
          { x: 4, y: 6, time: time + 5 }
        ]
      else
        [{ x: 6, y: 3, time: time + 1 }]
      end
    when [7, 3]
      can_reserve = [check(x: 7, y: 4, time: time + 1)].all? { |x| !x.nil? }
      if can_reserve
        [{ x: 7, y: 4, time: time + 1 }]
      else
        [{ x: 7, y: 3, time: time + 1 }]
      end
    when [4, 8]
      can_reserve = [check(x: 4, y: 7, time: time + 1)].all? { |x| !x.nil? }
      if can_reserve
        [{ x: 4, y: 7, time: time + 1 }]
      else
        [{ x: 4, y: 8, time: time + 1 }]
      end
    when [5, 8]
      can_reserve = [check(x: 5, y: 7, time: time + 1),
                     check(x: 5, y: 6, time: time + 2),
                     check(x: 5, y: 5, time: time + 3),
                     check(x: 6, y: 5, time: time + 4),
                     check(x: 7, y: 5, time: time + 5)].all? { |x| !x.nil? }
      if can_reserve
        [
          { x: 5, y: 7, time: time + 1 },
          { x: 5, y: 6, time: time + 2 },
          { x: 5, y: 5, time: time + 3 },
          { x: 6, y: 5, time: time + 4 },
          { x: 7, y: 5, time: time + 5 }
        ]
      else
        [{ x: 5, y: 8, time: time + 1 }]
      end
    else
      []
    end
  end

  private

  def self.check(x:, y:, time:)
    spa_tem_matrix = @intersection.find { |m| m[:time] == time }
    pos_matrix = spa_tem_matrix[:matrix] if spa_tem_matrix
    x = pos_matrix.find { |mat| mat[:x] == x && mat[:y] == y && mat[:free] == true }
    if x
      x[:free] = false
    else
      x = nil
    end
    x
  end
end
