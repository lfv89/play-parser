require 'spec_helper'

describe BaseBuilder do
  describe BaseBuilder::Node do
    let(:node) { BaseBuilder::Node.new(dependence_node) }
    let(:selector) { 'selector' }
    let(:dependence_node) { double('DependenceNode') }

    describe "#css" do
      it "calls css on its depenence node" do
        expect(dependence_node).to receive(:css).with(selector)
        node.css(selector)
      end
    end
  end
end
