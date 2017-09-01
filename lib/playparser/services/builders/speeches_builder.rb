class SpeechesBuilder
  SELECTOR = '> SPEECH'

  include BaseBuilder

  attr_accessor :speeches

  def build
    tap do |builder|
      builder.speeches = @node.map do |node|
        Speech.new.tap do |speech|
          speech.title  = get_title(node)
          speech.speaker = speaker_builder(node).speaker
        end
      end
    end
  end

  private

  def speaker_builder(node)
    SpeakerBuilder.new(node).build
  end
end
