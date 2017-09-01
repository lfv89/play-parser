class Play
  include LineAggregatable

  attr_accessor :title, :acts

  aggregate_lines_from :acts

  def speakers_with_line_counts(options={})
    options ||= { except: '' }
    line_counts.tap { |h| h.delete(options[:except]) }
  end

  private

  def line_counts
    lines.reduce({}) do |memo, line|
      memo[line[:speaker]] = memo.fetch(line[:speaker], 0) + line[:count]
      memo
    end
  end
end
