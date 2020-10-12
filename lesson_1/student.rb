class Student
  attr_accessor :name

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

john = Student.new('john', 90)

bob = Student.new('bob', 95)

p john.better_grade_than?(bob)