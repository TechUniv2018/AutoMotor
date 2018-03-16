## Car object will have a beginning and an end
class Car
  attr_accessor :starting, :ending
  attr_accessor :will_turn, :time
  attr_accessor :id, :position_vector

  @width = Math.sqrt(2)
  @height = 2 * @width

  def initialize(id:, starting:, will_turn:, time:)
    @id = id
    @starting = starting
    @ending = get_ending(starting, will_turn)
    @will_turn = will_turn
    @time = time
  end

  def request
   
  end

  def to_s
    "id: #{id}, starting: #{starting}, time: #{time}, turn?: #{will_turn}"
  end

  private

  def get_ending(starting, will_turn)
    ending = starting + 8
    ending += 2 if will_turn
    ending += 4 if will_turn && starting.odd?
    ending
  end
end
