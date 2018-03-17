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
    @position_vector = padding(time)
    @time = time
  end

  def move(cars, t)
    return false if time != t
    # position_vector.push(x: 2, y: 4, time: 4) if t==3 && id==44
    curr_pos = position_vector.last
    x = curr_pos[:x]
    y = curr_pos[:y]
    curr_time = curr_pos[:time]
    @time = curr_time + 1
    new_x = @turn ? update_y(x) : update_x(x)
    new_y = @turn ? update_x(y) : update_y(y)
    if car_in_front(new_x, new_y, curr_time, cars)
      position_vector.push(x: x, y: y, time: time)
    else
      position_vector.push(x: new_x, y: new_y, time: time)
    end
  end

  def position_at(time)
    current = @position_vector.select { |i| i[:time] == time }.first
    current
  end

  def position
    current = @position_vector.last
    [current[:x], current[:y]]
  end

  def to_s
    "id: #{id}, lane: #{starting}, start_time: #{time}, turn?: #{will_turn}"
  end

  private

  def padding(time)
    x = get_x_coord(starting)
    y = get_y_coord(starting)
    arr = []
    (0..time - 1).each do |t|
      arr.push(x: -1, y: -1, time: t)
    end
    arr.push(x: x, y: y, time: time)
  end

  def car_in_front(new_x, new_y, time, cars)
    cars = cars.reject { |car| car.id == @id }
    cars = cars.select do |car|
      coords = { x: new_x, y: new_y, time: time + 1 }
      car_coords = car.position_at(time + 1)
      puts "hhhh #{car_coords} == #{coords}, #{coords == car_coords}"
      coords == car_coords
    end
    !cars.empty?
  end

  def get_x_coord(starting)
    coord = { 1 => 0, 2 => 0, 3 => 4, 4 => 5, 5 => 11, 6 => 11, 7 => 7, 8 => 8 }
    coord[starting]
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
