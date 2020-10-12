class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def to_s
    "You've got a #{self.color} #{self.year} #{self.model} running #{self.speed} mph!"
  end

  def self.calculate_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
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
# jimmy.shut_off
# puts jimmy.speed
jimmy.spray_paint('white')
puts jimmy.color

MyCar.calculate_mileage(351, 13)

puts jimmy