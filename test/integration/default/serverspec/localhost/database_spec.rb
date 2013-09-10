require 'spec_helper'

describe 'MyFace database' do

  it 'should be running the database server' do
    case RSpec.configuration.os
    when "Debian"
      expect(service 'mysql').to be_running
      expect(service 'mysql').to be_enabled
    else
      expect(service 'mysqld').to be_running
      expect(service 'mysqld').to be_enabled
    end
  end

  it 'should have created the myface database' do
    expect(command 'mysqlshow -uroot -prootpass').to return_stdout /.*myface.*/
  end

  it 'should have created the myface_app user' do
    expect(command 'mysql -uroot -prootpass -e "select user,host from mysql.user;"').to return_stdout /.*myface_app\s+localhost.*/
  end

  it 'should have given the myface_app database user rights to myface' do
    expect(command 'mysql -uroot -prootpass -e "show grants for \'myface_app\'@\'localhost\';"').to return_stdout /.*GRANT ALL PRIVILEGES ON `myface`.\* TO \'myface_app\'@\'localhost\'.*/
  end

  it 'should have created the users table' do
    expect(command 'mysql -hlocalhost -umyface_app -psupersecret -Dmyface -e "select id,user_name from users;"').to return_stdout /.*mbower.*/
  end

  it 'should have installed the Apache php5_module' do
    case RSpec.configuration.os
    when "Debian"
      expect(command 'sudo /usr/sbin/apache2 -M | grep php5').to return_stdout /.*php5_module.*/
    else
      expect(command 'sudo /usr/sbin/httpd -M | grep php5').to return_stdout /.*php5_module.*/
    end
  end

end
