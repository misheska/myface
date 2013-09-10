require 'spec_helper'

describe 'MyFace webserver' do

  it 'should have a myface user' do
    expect(command 'getent passwd myface').to return_stdout /myface:x:\d+:\d+::\/home\/myface:\/bin\/bash/
  end

end
