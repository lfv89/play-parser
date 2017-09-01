class ActsBuilder
  SELECTOR = '> ACT'

  include BaseBuilder

  attr_accessor :acts

  def build
    tap do |builder|
      builder.acts = @node.map do |node|
        Act.new.tap do |act|
          act.title  = get_title(node)
          act.scenes = scenes_builder(node).scenes
        end
      end
    end
  end

  private

  def scenes_builder(node)
    ScenesBuilder.new(node).build
  end
end
