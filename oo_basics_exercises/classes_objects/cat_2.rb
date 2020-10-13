class Cat
  attr_accessor :name
  @@total_cats = 0
  COLOR = 'gray'

  def initialize(name)
    @name = name
    @@total_cats += 1
  end

  def rename(new_name)
    self.name = new_name
  end

  def identify
    self
  end

  def self.generic_greeting
    puts "A cat I am."
  end
  
  def greet
    puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
  end

  def self.total
    puts @@total_cats
  end
end

kitty = Cat.new('Sophie')
kitty.greet
