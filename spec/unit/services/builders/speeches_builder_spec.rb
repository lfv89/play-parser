require 'spec_helper'

describe SpeechesBuilder do
  let(:speech)  { double('Speech') }
  let(:title) { 'Speech Title'  }
  let(:speechs_builder) { SpeechesBuilder.new(content) }

  let(:node) { double('Node') }
  let(:nodes) { 3.times.map { node } }
  let(:content) { double('SpeechContent') }

  let(:speaker) { double('Speaker') }
  let(:speaker_builder) { double('SpeakerBuilder') }

  before do
    allow(speech).to receive(:title=)
    allow(speech).to receive(:speaker=)
    allow(Speech).to receive(:new).and_return(speech)

    allow(content).to receive(:css).with('> SPEECH').and_return(nodes)
    allow(node).to receive_message_chain(:css, :children, :text).and_return(title)

    allow(SpeakerBuilder).to receive(:new).and_return(speaker_builder)
    allow(speaker_builder).to receive_message_chain(:build, :speaker).and_return(speaker)
  end

  describe '#build' do
    it 'returns a SpeechBuilder instance' do
      expect(speechs_builder.build).to be_instance_of(SpeechesBuilder)
    end

    it 'assigns the speech title' do
      expect(speech).to receive(:title=).with(title).exactly(3).times
      speechs_builder.build
    end

    it 'assigns the speech speaker' do
      expect(speech).to receive(:speaker=).with(speaker).exactly(3).times
      speechs_builder.build
    end
  end
end
