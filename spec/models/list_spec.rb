require 'rails_helper'
require 'spec_helper'

describe List do
  it 'sends api req' do
    List.create(name: 'test')
  end
end
