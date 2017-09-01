class PlayBuilder
  SELECTOR = 'PLAY'

  include BaseBuilder

  attr_accessor :play

  def build
    tap do |builder|
      builder.play = Play.new.tap do |play|
        play.title = get_title(@node)
        play.acts  = acts_builder(@node).acts
      end
    end
  end

  private

  def acts_builder(node)
    ActsBuilder.new(node).build
  end
end
