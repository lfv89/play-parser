class Outputter
  def initialize(content)
    @content = content
  end

  def execute
    @content.each { |key, value| puts format(key, value) }
  end

  private

  def format(key, value)
    "#{value} #{key}"
  end
end
