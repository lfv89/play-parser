module LineAggregatable
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    attr_reader :aggregatable

    def aggregate_lines_from(aggregatable)
      @aggregatable = aggregatable
    end
  end

  def lines
    aggregator.new(send(self.class.aggregatable)).execute
  end

  private

  def aggregator
    LineAggregator
  end
end
