require 'spec_helper'

describe PlayBuilder do
  let(:play)  { double('Play') }
  let(:title) { 'Play Title'   }
  let(:play_builder) { PlayBuilder.new(content) }

  let(:node) { double('Node') }
  let(:content) { double('PlayContent') }

  let(:acts) { 3.times.map { double('Act') } }
  let(:acts_builder) { double('ActsBuilder') }

  before do
    allow(play).to receive(:acts=)
    allow(play).to receive(:title=)
    allow(Play).to receive(:new).and_return(play)

    allow(content).to receive(:css).with('PLAY').and_return(node)
    allow(node).to receive_message_chain(:css, :children, :text).and_return(title)

    allow(ActsBuilder).to receive(:new).and_return(acts_builder)
    allow(acts_builder).to receive_message_chain(:build, :acts).and_return(acts)
  end

  describe '#build' do
    it 'returns a PlayBuilder instance' do
      expect(play_builder.build).to be_instance_of(PlayBuilder)
    end

    it 'assigns the play title' do
      expect(play).to receive(:title=).with(title)
      play_builder.build
    end

    it 'assigns the play acts' do
      expect(play).to receive(:acts=).with(acts)
      play_builder.build
    end
  end
end
