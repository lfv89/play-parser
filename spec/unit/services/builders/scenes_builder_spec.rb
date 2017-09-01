require 'spec_helper'

describe ScenesBuilder do
  let(:scene)  { double('Scene') }
  let(:title) { 'Scene Title'  }
  let(:scenes_builder) { ScenesBuilder.new(content) }

  let(:node) { double('Node') }
  let(:nodes) { 3.times.map { node } }
  let(:content) { double('SceneContent') }

  let(:speeches) { 3.times.map { double('Speech') } }
  let(:speeches_builder) { double('SpeechesBuilder') }

  before do
    allow(scene).to receive(:title=)
    allow(scene).to receive(:speeches=)
    allow(Scene).to receive(:new).and_return(scene)

    allow(content).to receive(:css).with('> SCENE').and_return(nodes)
    allow(node).to receive_message_chain(:css, :children, :text).and_return(title)

    allow(SpeechesBuilder).to receive(:new).and_return(speeches_builder)
    allow(speeches_builder).to receive_message_chain(:build, :speeches).and_return(speeches)
  end

  describe '#build' do
    it 'returns a SceneBuilder instance' do
      expect(scenes_builder.build).to be_instance_of(ScenesBuilder)
    end

    it 'assigns the scene title' do
      expect(scene).to receive(:title=).with(title).exactly(3).times
      scenes_builder.build
    end

    it 'assigns the scene speeches' do
      expect(scene).to receive(:speeches=).with(speeches).exactly(3).times
      scenes_builder.build
    end
  end
end
