require 'spec_helper'

describe SpeakerBuilder do
  let(:speaker)  { double('Speaker') }
  let(:name) { 'Speaker Name'   }
  let(:speaker_builder) { SpeakerBuilder.new(content) }

  let(:node) { double('Node') }
  let(:content) { double('SpeakerContent') }

  let(:lines) { 3.times.map { double('Line') } }
  let(:lines_builder) { double('LinesBuilder') }

  before do
    allow(speaker).to receive(:name=)
    allow(speaker).to receive(:lines=)
    allow(Speaker).to receive(:new).and_return(speaker)

    allow(content).to receive(:css).with('> SPEAKER').and_return(node)
    allow(content).to receive_message_chain(:css, :children, :text).and_return(name)

    allow(LinesBuilder).to receive(:new).and_return(lines_builder)
    allow(lines_builder).to receive_message_chain(:build, :lines).and_return(lines)
  end

  describe '#build' do
    it 'returns a SpeakerBuilder instance' do
      expect(speaker_builder.build).to be_instance_of(SpeakerBuilder)
    end

    it 'assigns the speaker name' do
      expect(speaker).to receive(:name=).with(name)
      speaker_builder.build
    end

    it 'assigns the speaker lines' do
      expect(speaker).to receive(:lines=).with(lines)
      speaker_builder.build
    end
  end
end
