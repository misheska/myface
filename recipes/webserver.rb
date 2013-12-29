#
# Cookbook Name:: myface
# Recipe:: webserver
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

group node['myface']['group']

user node['myface']['user'] do
  group node['myface']['group']
  system true
  shell '/bin/bash'
end

include_recipe 'apache2'
include_recipe 'apache2::mod_php5'

package 'php-mysql' do
  action :install
  notifies :restart, 'service[apache2]'
end

# disable default site
apache_site '000-default' do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/#{node['myface']['config']}" do
  source 'apache2.conf.erb'
  notifies :restart, 'service[apache2]'
end

# create document root
directory "#{node['myface']['document_root']}" do
  action :create
  recursive true
end

# write site
cookbook_file "#{node['myface']['document_root']}/index.html" do
  mode "0644"
end

# enable myface
apache_site "#{node['myface']['config']}" do
  enable true
end
