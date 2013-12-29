require 'spec_helper'

describe 'MyFace webserver' do

  it 'should have a myface user' do
    expect(user 'myface').to exist
  end

  it 'should be running the httpd server' do
    case RSpec.configuration.os[:family]
    when "Ubuntu"
      expect(service 'apache2').to be_running
      expect(service 'apache2').to be_enabled
    else
      expect(service 'httpd').to be_running
      expect(service 'httpd').to be_enabled
    end
  end

  it 'should respond to an HTTP request' do
    expect(command 'curl localhost').to return_stdout /.*<title>MyFace Users<\/title>.*/
  end

end
