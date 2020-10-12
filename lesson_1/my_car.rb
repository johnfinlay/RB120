module TruckBeds
  def load_bed(item_count, weight)
    puts "You've added #{item_count} items weighing #{weight} lbs. to the truck bed."
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@total_vehicles = 0

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@total_vehicles += 1
  end

  def self.vehicle_count
    puts "#{@@total_vehicles} vehicles on the road!"
  end

  def to_s
    "You've got a #{self.color} #{self.year} #{self.model} running #{self.speed} mph!"
  end

  def self.calculate_mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
  end

  def age
    puts "This vehicle is #{calculate_age} years old."
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

  private

  def calculate_age
    this_year = Time.new
    this_year.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  include TruckBeds

  NUMBER_OF_DOORS = 2
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

jimmy.age