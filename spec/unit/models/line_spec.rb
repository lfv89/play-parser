require 'spec_helper'

describe Line do
  let(:line) { Line.new }
  let(:content) { 'content' }

  it 'has a getter/setter for content' do
    expect { line.content = content }.to change { line.content}.from(nil).to(content)
  end
end

