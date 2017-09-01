require 'spec_helper'

describe Scene do
  let(:scene) { Scene.new }
  let(:subject) { scene }

  let(:title) { 'Scene Title' }
  let(:speeches) { [double('Speech')] }

  it_behaves_like "a line aggregatable", "speeches"

  it 'has a getter/setter for title' do
    expect { scene.title = title }.to change { scene.title }.from(nil).to(title)
  end

  it 'has a getter/setter for speeches' do
    expect { scene.speeches = speeches }.to change { scene.speeches }.from(nil).to(speeches)
  end
end

