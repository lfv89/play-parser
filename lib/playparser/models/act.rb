class Act
  include LineAggregatable

  attr_accessor :title, :scenes

  aggregate_lines_from :scenes
end
