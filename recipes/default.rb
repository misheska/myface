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
