#
# Cookbook Name:: myface
# Recipe:: database
#
# Copyright (C) 2012 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "mysql::server"
include_recipe "database::mysql"

mysql_database node[:myface][:database][:dbname] do
  connection(
    :host => node[:myface][:database][:host],
    :username => node[:myface][:database][:username],
    :password => node[:myface][:database][:password]
  )
  action :create
end
