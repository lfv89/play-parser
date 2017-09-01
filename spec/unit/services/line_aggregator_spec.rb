require 'spec_helper'

describe LineAggregator do
  let(:lines1) { [ { speaker: '1s1', count: 1 }, { speaker: '1s2', count: 2 } , { speaker: '1s3', count: 3 } ] }
  let(:lines2) { [ { speaker: '2s1', count: 4 }, { speaker: '2s2', count: 5 } , { speaker: '2s3', count: 6 } ] }
  let(:lines3) { [ { speaker: '3s1', count: 7 }, { speaker: '3s2', count: 8 } , { speaker: '3s3', count: 9 } ] }

  let(:lineable1)  { double('Scene') }
  let(:lineable2)  { double('Scene') }
  let(:lineable3)  { double('Scene') }

  let(:lineables) { [lineable1, lineable2, lineable3] }
  let(:line_aggregator) { LineAggregator.new(lineables) }

  before { lineables.each_with_index { |lineable, i| allow(lineable).to receive(:lines).and_return(send("lines#{i+1}")) } }

  describe "#execute" do
    it 'aggregates in an array all the lines of each one of the lineables' do
      expect(line_aggregator.execute.length).to eq(9)
    end

    it 'aggregates in an array all the count of each one of the lineables' do
      expect(line_aggregator.execute.map { |line| line[:count] }).to match_array((1..9).to_a)
    end

    it 'aggregates in an array all the speakers of each one of the lineables' do
      expect(line_aggregator.execute.map { |line| line[:speaker] }).to match_array(%w(1s1 2s1 3s1 1s2 2s2 3s2 1s3 2s3 3s3))
    end
  end
end
