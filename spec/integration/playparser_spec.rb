require 'spec_helper'

describe "The playparser" do
  let(:http_dependence) { OpenURI }
  let(:http_dependence_method) { :open }

  let(:all) { 'ALL' }
  let(:all_line_count) { 1 }

  let(:speaker1) { 'spk1' }
  let(:speaker1_line_count) { 2 }

  let(:speaker2) { 'spk2' }
  let(:speaker2_line_count) { 8 }

  let(:speaker3) { 'spk3' }
  let(:speaker3_line_count) { 27 }

  let(:sample_play) do
    %Q(
      <PLAY>
        <ACT>
          <SCENE>
            <SPEECH>
              <SPEAKER>ALL</SPEAKER>
              <LINE>CONTENT</LINE>
            </SPEECH>
            <SPEECH>
              <SPEAKER>#{speaker1}</SPEAKER>
              #{lines_builder_for(speaker1_line_count)}
            </SPEECH>
          </SCENE>
          <SCENE>
            <SPEECH>
              <SPEAKER>#{speaker2}</SPEAKER>
              #{lines_builder_for(speaker2_line_count / 2)}
            </SPEECH>
            <SPEECH>
              <SPEAKER>#{speaker3}</SPEAKER>
              #{lines_builder_for(speaker3_line_count * 2/3)}
            </SPEECH>
          </SCENE>
        </ACT>
        <ACT>
          <SCENE>
            <SPEECH>
              <SPEAKER>#{speaker2}</SPEAKER>
              #{lines_builder_for(speaker2_line_count / 2)}
            </SPEECH>
            <SPEECH>
              <SPEAKER>#{speaker3}</SPEAKER>
              #{lines_builder_for(speaker3_line_count * 1/3)}
            </SPEECH>
          </SCENE>
        </ACT>
      </PLAY>
    )
  end

  def lines_builder_for(count)
    [].tap do |lines|
      count.times do |n|
        lines << '<LINE>CONTENT</LINE>'
      end
    end.join('')
  end

  before { allow(http_dependence).to receive(http_dependence_method).and_return(sample_play) }

  it "doesn't output to STDOUT the line count of the ALL speaker" do
    expect(STDOUT).not_to receive(:puts).with("#{all} #{all_line_count}")

    Playparser.config
    Playparser.execute
  end

  it "outputs to STDOUT the line count of each speaker on the sample play" do
    3.times { |n| expect(STDOUT).to receive(:puts).with("#{send("speaker#{n+1}_line_count")} #{send("speaker#{n+1}")}").once }

    Playparser.config
    Playparser.execute
  end
end
