require 'spec_helper'

describe FileGetter do
  let(:url) { 'http://foo.bar' }
  let(:raw_play) { '<play></play>' }

  let(:dependence_method) { :get_method }
  let(:dependence) { double('HttpDependence', { dependence_method => raw_play }) }

  let(:file_getter) { FileGetter.new(url) }

  before do
    FileGetter.dependence = nil
    FileGetter.dependence_method = nil
  end

  describe '.dependence' do
    it "receives the FileGetter's dependence" do
      expect { FileGetter.dependence = dependence }.to change { FileGetter.dependence }.from(nil).to(dependence)
    end
  end

  describe '.dependence_method' do
    it "receives the FileGetter's method dependence" do
      expect { FileGetter.dependence_method = dependence_method }.to change { FileGetter.dependence_method }.from(nil).to(dependence_method)
    end
  end

  describe '#content' do
    before do
      FileGetter.dependence = dependence
      FileGetter.dependence_method = dependence_method
    end

    it 'returns the raw_play file' do
      expect(file_getter.content).to eq(raw_play)
    end

    it "passes the url to the method of its dependence" do
      allow(dependence).to receive(dependence_method).with(url).once
    end
  end
end
