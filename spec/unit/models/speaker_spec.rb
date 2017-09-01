require 'spec_helper'

describe Speaker do
  let(:speaker) { Speaker.new }
  let(:name) { 'Speaker Name' }
  let(:lines) { [double('Line')] }

  it 'has a getter/setter for name' do
    expect { speaker.name = name }.to change { speaker.name }.from(nil).to(name)
  end

  it 'has a getter/setter for lines' do
    expect { speaker.lines = lines }.to change { speaker.lines }.from(nil).to(lines)
  end
end

