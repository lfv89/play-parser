require 'spec_helper'

describe Act do
  let(:act) { Act.new }
  let(:subject) { act }

  let(:title) { 'Act Title' }
  let(:scenes) { [double('Scene')] }

  it_behaves_like "a line aggregatable", "scenes"

  it 'has a getter/setter for title' do
    expect { act.title = title }.to change { act.title }.from(nil).to(title)
  end

  it 'has a getter/setter for scenes' do
    expect { act.scenes = scenes }.to change { act.scenes }.from(nil).to(scenes)
  end
end

