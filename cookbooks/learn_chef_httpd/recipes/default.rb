#
# Cookbook Name:: learn_chef_httpd
# Recipe:: default
#
# Copyright (C) 2014
#
#
#
bash 'Updating system' do

    code <<-EOH
  	yum update -y
     EOH
end
yum_package 'httpd' do
  action :install
end

service 'httpd' do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

service 'iptables' do
  action :stop
end
