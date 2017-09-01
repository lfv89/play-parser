class LinesBuilder
  SELECTOR = '> LINE'

  include BaseBuilder

  attr_accessor :lines

  def build
    tap do |builder|
      builder.lines = @node.map do |node|
        Line.new.tap do |line|
          line.content = get_content(node)
        end
      end
    end
  end
end
