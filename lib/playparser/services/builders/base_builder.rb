module BaseBuilder
  TITLE_SELECTOR = '> TITLE'

  class Node
    def initialize(node)
      @node = node
    end

    def css(selector)
      @node.css(selector)
    end
  end

  def self.included(base)
    @base = base
  end

  def initialize(node)
    @node = Node.new(node).css(self.class.const_get('SELECTOR'))
  end

  def get_title(node)
    get_content(node.css(TITLE_SELECTOR))
  end

  def get_content(node)
    node.children.text
  end
end
