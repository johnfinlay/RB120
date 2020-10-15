class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# The to_s call in Pet#initialize returns
# a new String object that is assigned to @name
# The reassignment of the local variable name
# on line 15 does not affect the @name object

# If the local variable name is already a string,
# then the original String object will be assigned to @name.
# That is why the original #upcase! call modified
# the local variable name in the original exercise.
