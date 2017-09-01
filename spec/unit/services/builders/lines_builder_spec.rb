require 'spec_helper'

describe LinesBuilder do
  let(:line)  { double('Line') }
  let(:content) { 'Line Content' }
  let(:lines_builder) { LinesBuilder.new(content) }

  let(:node) { double('Node') }
  let(:nodes) { 3.times.map { node } }
  let(:content) { double('LineContent') }

  before do
    allow(line).to receive(:content=)
    allow(Line).to receive(:new).and_return(line)

    allow(content).to receive(:css).with('> LINE').and_return(nodes)
    allow(node).to receive_message_chain(:children, :text).and_return(content)
  end

  describe '#build' do
    it 'returns a LineBuilder instance' do
      expect(lines_builder.build).to be_instance_of(LinesBuilder)
    end

    it 'assigns the line content' do
      expect(line).to receive(:content=).with(content).exactly(3).times
      lines_builder.build
    end
  end
end
