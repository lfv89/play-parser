require 'spec_helper'

shared_examples "a line aggregatable" do |aggregation_name|
  let(:line_aggregator) { LineAggregator }
  let(:line_aggregator_instance) { double('Aggregator', execute: nil) }

  let(:aggregation_name) { aggregation_name }
  let(:aggregation_value) { double('Aggregation') }

  before { subject.send("#{aggregation_name}=", aggregation_value) }

  describe "#lines" do
    it "instantiates an aggregator" do
      expect(line_aggregator).to receive(:new).with(aggregation_value).and_return(line_aggregator_instance).once
      subject.lines
    end

    it "calls execute on the aggregator" do
      allow(line_aggregator).to receive(:new).with(aggregation_value).and_return(line_aggregator_instance)
      expect(line_aggregator_instance).to receive(:execute).once
      subject.lines
    end
  end
end
