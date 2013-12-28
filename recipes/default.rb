#
# Cookbook Name:: myface
# Recipe:: default
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

# disable default site
apache_site '000-default' do
  enable false
end

# create apache config
template "#{node['apache']['dir']}/sites-available/myface.conf" do
  source 'apache2.conf.erb'
  notifies :restart, 'service[apache2]'
end

# create document root
directory '/srv/apache/myface' do
  action :create
  recursive true
end

# write site
cookbook_file '/srv/apache/myface/index.html' do
  mode '0644' # forget me to create debugging exercise
end

# enable myface
apache_site 'myface.conf' do
  enable true
end
