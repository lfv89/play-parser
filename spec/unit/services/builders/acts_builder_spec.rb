require 'spec_helper'

describe ActsBuilder do
  let(:act)  { double('Act') }
  let(:title) { 'Act Title'  }
  let(:acts_builder) { ActsBuilder.new(content) }

  let(:node) { double('Node') }
  let(:nodes) { 3.times.map { node } }
  let(:content) { double('ActContent') }

  let(:scenes) { 3.times.map { double('Scene') } }
  let(:scenes_builder) { double('ScenesBuilder') }

  before do
    allow(act).to receive(:title=)
    allow(act).to receive(:scenes=)
    allow(Act).to receive(:new).and_return(act)

    allow(content).to receive(:css).with('> ACT').and_return(nodes)
    allow(node).to receive_message_chain(:css, :children, :text).and_return(title)

    allow(ScenesBuilder).to receive(:new).and_return(scenes_builder)
    allow(scenes_builder).to receive_message_chain(:build, :scenes).and_return(scenes)
  end

  describe '#build' do
    it 'returns an ActBuilder instance' do
      expect(acts_builder.build).to be_instance_of(ActsBuilder)
    end

    it 'assigns the act title' do
      expect(act).to receive(:title=).with(title).exactly(3).times
      acts_builder.build
    end

    it 'assigns the act scenes' do
      expect(act).to receive(:scenes=).with(scenes).exactly(3).times
      acts_builder.build
    end
  end
end
