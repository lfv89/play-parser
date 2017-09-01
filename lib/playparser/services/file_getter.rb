class FileGetter
  attr_reader :url, :content

  class << self
    attr_accessor :dependence, :dependence_method
  end

  def initialize(url)
    @url = url
    @dependence = self.class.dependence
    @dependence_method = self.class.dependence_method
  end

  def content
    @content ||= @dependence.method(@dependence_method).call(url)
  end
end
