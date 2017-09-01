class LineAggregator
  def initialize(lineables)
    @lineables = lineables
  end

  def execute
    [].tap do |spoken_lines|
      @lineables.each do |lineable|
        lineable.lines.each do |line|
          spoken_lines << line
        end
      end
    end
  end
end
