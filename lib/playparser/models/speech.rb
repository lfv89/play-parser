class Speech
  attr_accessor :title, :speaker

  def lines
    [{
      speaker: speaker.name,
      count: speaker.lines.length
    }]
  end
end
