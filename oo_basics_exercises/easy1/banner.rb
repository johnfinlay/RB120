class Banner
  def initialize(message, width = 0)
    @message = message
    @width = width >= message.length ? width : message.length
    @half_width, @remainder = (@width - message.length).divmod(2)
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    @horizontal_rule = "+-#{'-' * @width}-+"
  end

  def empty_line
    @empty_line = "| #{' ' * @width} |"
  end

  def message_line
    if @message.length.zero?
      empty_line
    else
      "| #{' ' * @half_width}#{@message}#{' ' * (@half_width + @remainder)} |"
    end
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 56)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('', 17)
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+
