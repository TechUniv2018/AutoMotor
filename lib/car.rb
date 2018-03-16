## Car object will have a beginning and an end
class Car
  attr_accessor :starting, :ending
  attr_accessor :will_turn, :time
  attr_accessor :id, :position_vector
  attr_accessor :turn

  @width = Math.sqrt(2)
  @height = 2 * @width

  def initialize(id:, starting:, will_turn:, time:)
    @turn = false
    @id = id
    @starting = starting
    @ending = get_ending(starting, will_turn)
    @will_turn = will_turn
    x = get_x_coord(starting)
    y = get_y_coord(starting)
    @position_vector = [].push(x: x, y: y, time: time)
    @time = time
  end

  def check_front(cars, t)
    obj = position_vector.last
    x, y, time = obj[:x], obj[:y], obj[:time]
    if time == t
      new_x = @turn ? update_y(x) : update_x(x)
      new_y = @turn ? update_x(y) : update_y(y)
      new_time = time + 1
      position_vector.push(x: new_x, y: new_y, time: new_time)
    end
  end


  def position
    current = @position_vector.last
    [current[:x], current[:y]]
  end

  def to_s
    "id: #{id}, starting: #{starting},time: #{time}, turn?: #{will_turn},
    \ position: #{position_vector}"
  end

  private

  def get_x_coord(starting)
    case starting
    when 1, 2
      0
    when 5, 6
      11
    when 3
      4
    when 4
      5
    when 7
      7
    when 8
      8
    end
  end

  def get_y_coord(starting)
    case starting
    when 3, 4
      11
    when 7, 8
      0
    when 1
      4
    when 2
      5
    when 5
      7
    when 6
      6
    end
  end

  def update_x(x)
    case @starting
    when 1, 2
      x + 1
    when 5, 6
      x - 1
    else
      x
    end
  end

  def update_y(y)
    case @starting
    when 7, 8
      y + 1
    when 3, 4
      y - 1
    else
      y
    end
  end

  def get_ending(starting, will_turn)
    ending = starting + 8
    ending += 2 if will_turn
    ending += 4 if will_turn && starting.odd?
    ending
  end
end
