require 'spec_helper'

describe FileParser do
  let(:file) { '<play></play>' }
  let(:parsed_play) { double('Play') }

  let(:dependence_method) { :parse_method }
  let(:dependence) { double('ParserDependence', { dependence_method => parsed_play }) }

  let(:file_getter) { FileGetter.new(file) }

  before do
    FileParser.dependence = nil
    FileParser.dependence_method = nil
  end

  describe '.dependence' do
    it "receives the FileParser's dependence" do
      expect { FileParser.dependence = dependence }.to change { FileParser.dependence }.from(nil).to(dependence)
    end
  end

  describe '.dependence_method' do
    it "receives the FileParser's method dependence" do
      expect { FileParser.dependence_method = dependence_method }.to change { FileParser.dependence_method }.from(nil).to(dependence_method)
    end
  end

  describe '#content' do
    before do
      FileGetter.dependence = dependence
      FileGetter.dependence_method = dependence_method
    end

    it 'returns the parsed_play file' do
      expect(file_getter.content).to eq(parsed_play)
    end

    it "passes the file to the method of its dependence" do
      allow(dependence).to receive(dependence_method).with(file).once
    end
  end
end
