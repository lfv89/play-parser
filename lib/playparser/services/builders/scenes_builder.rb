class ScenesBuilder
  SELECTOR = '> SCENE'

  include BaseBuilder

  attr_accessor :scenes

  def build
    tap do |builder|
      builder.scenes = @node.map do |node|
        Scene.new.tap do |scene|
          scene.title = get_title(node)
          scene.speeches = speeches_builder(node).speeches
        end
      end
    end
  end

  private

  def speeches_builder(node)
    SpeechesBuilder.new(node).build
  end
end

