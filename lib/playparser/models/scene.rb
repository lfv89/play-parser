class Scene
  include LineAggregatable

  attr_accessor :title, :speeches

  aggregate_lines_from :speeches
end
