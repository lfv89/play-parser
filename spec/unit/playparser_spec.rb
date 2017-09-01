require 'spec_helper'

describe Playparser do
  let(:version) { '0.1.0' }
  let(:url) { 'http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml' }

  let(:http_dependence) { OpenURI }
  let(:http_dependence_method) { :open }

  let(:parse_dependence) { Nokogiri::XML }
  let(:parse_dependence_method) { :parse }

  let(:outputter)   { Outputter }
  let(:file_getter) { FileGetter }
  let(:file_parser) { FileParser }

  after do
    [file_getter, file_parser].each do |dependendable|
      dependendable.dependence = nil
      dependendable.dependence_method = nil
    end
  end

  before { allow(http_dependence).to receive(:open).and_return('') }

  it 'has a version number' do
    expect(Playparser::VERSION).to eq(version)
  end

  it "has the play's url" do
    expect(Playparser.configs.url).to eq(url)
  end

  describe ".config" do
    it "configure the FileGetter's dependence" do
      expect { Playparser.config }.to change { FileGetter.dependence }.from(nil).to(http_dependence)
    end

    it "configure the FileGetter's method dependence" do
      expect { Playparser.config }.to change { FileGetter.dependence_method }.from(nil).to(http_dependence_method)
    end

    it "configure the FileParser's dependence" do
      expect { Playparser.config }.to change { FileParser.dependence }.from(nil).to(parse_dependence)
    end

    it "configure the FileParser's method dependence" do
      expect { Playparser.config }.to change { FileParser.dependence_method }.from(nil).to(parse_dependence_method)
    end
  end

  describe ".execute" do
    before { Playparser.config }

    it 'instantiates the FileGetter passing the Playparser::URL' do
      expect(file_getter).to receive(:new).with(Playparser.configs.url).and_call_original
      Playparser.execute
    end

    it 'calls content on the FileGetter instance' do
      file_getter_instance = file_getter.new(Playparser.configs.url)
      allow(file_getter).to receive(:new).and_return(file_getter_instance)

      expect(file_getter_instance).to receive(:content).and_call_original
      Playparser.execute
    end

    it 'instantiates the FileParser passing the content from FileGetter' do
      file_getter_instance = double('FileGetter', content: 'content-to-parse')
      allow(file_getter).to receive(:new).and_return(file_getter_instance)

      expect(file_parser).to receive(:new).with('content-to-parse').and_call_original
      Playparser.execute
    end

    it 'calls content on the FileParser instance' do
      file_getter_instance = double('FileGetter', content: 'content-to-parse')
      allow(file_getter).to receive(:new).and_return(file_getter_instance)

      file_parser_instance = double('Content', content: double('Node1', css: double('Node2', css: double('Node3', map: [], children: double('Node4', text: '')))))
      allow(file_parser).to receive(:new).and_return(file_parser_instance)

      expect(file_parser_instance).to receive(:content).once
      Playparser.execute
    end

    it 'instantiates the Outputter passing the speakers with line counts' do
      play_instance = Play.new
      output_instance = double('Output')
      content = double('SpeakersWithLineCounts')

      allow(output_instance).to receive(:execute)
      allow(Play).to receive(:new).and_return(play_instance)
      allow(play_instance).to receive(:speakers_with_line_counts).and_return(content)

      expect(outputter).to receive(:new).with(content).and_return(output_instance)
      Playparser.execute
    end

    it 'calls execute on the Outputter' do
      play_instance = Play.new
      outputter_instance = double('Output')
      content = double('SpeakersWithLineCounts')

      allow(outputter_instance).to receive(:execute)
      allow(Play).to receive(:new).and_return(play_instance)
      allow(outputter).to receive(:new).with(content).and_return(outputter_instance)
      allow(play_instance).to receive(:speakers_with_line_counts).and_return(content)

      expect(outputter_instance).to receive(:execute).once
      Playparser.execute
    end
  end
end
