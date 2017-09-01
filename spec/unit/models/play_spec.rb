require 'spec_helper'

describe Play do
  let(:play) { Play.new }
  let(:subject) { play }

  it_behaves_like "a line aggregatable", "acts"

  describe "The getters/setters" do
    let(:title) { 'Play Title' }
    let(:acts)  { [double('Act')] }

    it 'has a getter/setter for title' do
      expect { play.title = title }.to change { play.title }.from(nil).to(title)
    end

    it 'has a getter/setter for acts' do
      expect { play.acts = acts }.to change { play.acts }.from(nil).to(acts)
    end
  end

  describe '#speakers_with_line_counts' do
    let(:speaker1) { 'Spk1' }
    let(:count1)   { 5 }

    let(:speaker2) { 'Spk2' }
    let(:count2)   { 8 }

    let(:speaker3) { 'Spk3' }
    let(:count3)   { 2 }

    before do
      line1 = double('Line1')
      line2 = double('Line2')
      line3 = double('Line2')

      allow(line1).to receive(:[]).with(:speaker).and_return(speaker1)
      allow(line1).to receive(:[]).with(:count).and_return(count1)

      allow(line2).to receive(:[]).with(:speaker).and_return(speaker2)
      allow(line2).to receive(:[]).with(:count).and_return(count2)

      allow(line3).to receive(:[]).with(:speaker).and_return(speaker3)
      allow(line3).to receive(:[]).with(:count).and_return(count3)

      play.acts = [double('Act', lines: [line1]), double('Act', lines: [line2, line3])]
    end

    context 'when no exception is passed' do
      it 'returns the speakers with the line count of each one of them' do
        expect(play.speakers_with_line_counts).to eq({ speaker1 => count1, speaker2 => count2, speaker3 => count3})
      end
    end

    context 'when a excecption is passed' do
      let(:exception) { speaker3 }

      it 'returns the speakers with the line count of each one of them, excepct for the exception' do
        expect(play.speakers_with_line_counts(except: exception)).to eq({ speaker1 => count1, speaker2 => count2})
      end
    end
  end
end
