class SpeakerBuilder
  SELECTOR = '> SPEAKER'

  include BaseBuilder

  attr_accessor :speaker

  def initialize(node)
    @original_node = node
    super
  end

  def build
    tap do |builder|
      builder.speaker = Speaker.new.tap do |speaker|
        speaker.name = get_content(@node)
        speaker.lines = lines_builder(@original_node).lines
      end
    end
  end

  private

  def lines_builder(node)
    LinesBuilder.new(node).build
  end
end
