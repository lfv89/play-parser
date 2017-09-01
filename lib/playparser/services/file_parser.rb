class FileParser
  attr_reader :content

  class << self
    attr_accessor :dependence, :dependence_method
  end

  def initialize(file)
    @file = file
    @dependence = self.class.dependence
    @dependence_method = self.class.dependence_method
  end

  def content
    @content ||= @dependence.method(@dependence_method).call(@file)
  end
end
