#
# Cookbook Name:: myface
# Recipe:: database
#
# Copyright (C) 2012 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_database node['myface']['database']['dbname'] do
  connection(
    :host => node['myface']['database']['host'],
    :username => node['myface']['database']['username'],
    :password => node['myface']['database']['password']
  )
  action :create
end

mysql_database_user node['myface']['database']['app']['username'] do
  connection(
    :host => node['myface']['database']['host'],
    :username => node['myface']['database']['username'],
    :password => node['myface']['database']['password']
  )
  password node['myface']['database']['app']['password']
  database_name node['myface']['database']['dbname']
  host node['myface']['database']['host']
  action [:create, :grant]
end
