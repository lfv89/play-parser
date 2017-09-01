require 'spec_helper'

describe Outputter do
  let(:content) { { foo: 'bar', bar: 'foo' } }
  let(:outputter) { Outputter.new(content) }

  describe "#execute" do
    it "calls STDOUT#puts for each content element" do
      content.each do |key, value|
        expect(STDOUT).to receive(:puts).with("#{value} #{key}")
      end

      outputter.execute
    end
  end
end
