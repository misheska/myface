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

mysql_database_user node[:myface][:database][:app][:username] do
  connection(
    :host => node[:myface][:database][:host],
    :username => node[:myface][:database][:username],
    :password => node[:myface][:database][:password]
  )
  password node[:myface][:database][:app][:password]
  database_name node[:myface][:database][:dbname]
  host node[:myface][:database][:host]
  action [:create, :grant]
end

# Write schema seed file to filesystem
cookbook_file node[:myface][:database][:seed_file] do
  source "myface-create.sql"
  owner "root"
  group "root"
  mode "0600"
end

# Seed database with test data
execute "initialize myface database" do
  command "mysql -h #{node[:myface][:database][:host]} -u #{node[:myface][:database][:app][:username]} -p#{node[:myface][:database][:app][:password]} -D #{node[:myface][:database][:dbname]} < #{node[:myface][:database][:seed_file]}"
  not_if  "mysql -h #{node[:myface][:database][:host]} -u #{node[:myface][:database][:app][:username]} -p#{node[:myface][:database][:app][:password]} -D #{node[:myface][:database][:dbname]} -e 'describe users;'"
end
