class Banner
  def initialize(message)
    @message = message
    @filler = message.length + 2
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    @horizontal_rule = "+#{'-' * @filler}+"
  end

  def empty_line
    @empty_line = "|#{' ' * @filler}|"
  end

  def message_line
    "| #{@message} |"
  end

  # private

  # def message
  #   @message
  # end
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+
