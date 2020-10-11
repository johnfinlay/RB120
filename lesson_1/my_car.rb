class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def increase_speed(mph)
    @speed += mph
  end

  def brake(mph)
    @speed -= mph
  end

  def shut_off
    @speed = 0
  end

  def spray_paint(c)
    self.color = c
  end
end

jimmy = MyCar.new(1979, 'grey', 'GMC Jimmy')
jimmy.increase_speed(55)
puts jimmy.speed
jimmy.brake(25)
puts jimmy.speed
jimmy.shut_off
puts jimmy.speed
jimmy.spray_paint('white')
puts jimmy.color
