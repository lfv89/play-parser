require 'spec_helper'

describe Speech do
  let(:speech) { Speech.new }

  let(:name) { 'Spk1' }
  let(:lines) { [double('Line')] }

  let(:title) { 'Speech Title' }
  let(:speaker) { double('Speaker', name: name, lines: lines ) }

  describe "The getters/setters" do
    it 'has a getter/setter for title' do
      expect { speech.title = title }.to change { speech.title }.from(nil).to(title)
    end

    it 'has a getter/setter for speaker' do
      expect { speech.speaker = speaker }.to change { speech.speaker }.from(nil).to(speaker)
    end
  end

  describe "#lines" do
    before { speech.speaker = speaker }

    it "returns a data structure with 1 element" do
      expect(speech.lines.length).to eq(1)
    end

    it "returns a data structure containing the speech's speaker" do
      expect(speech.lines.first[:speaker]).to eq(name)
    end

    it "returns data structure containing the speech's speaker line count" do
      expect(speech.lines.first[:count]).to eq(lines.length)
    end
  end
end

