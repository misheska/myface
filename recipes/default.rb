#
# Cookbook Name:: myface
# Recipe:: default
#
# Copyright (C) 2013 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

group "myface"

user "myface" do
  group "myface"
  system true
  shell "/bin/bash"
end
