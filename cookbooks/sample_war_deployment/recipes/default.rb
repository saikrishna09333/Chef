#
# Cookbook Name:: sample_war_deployment
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute "yum-update" do
  command "sudo yum update -y"
  ignore_failure true
end
 ###installing tomcat7###
package 'tomcat' do
        action :install
end
###Clearing tomcat7 webapps ROOT folder###
bash 'Clearing tomcat7 webapps ROOT folder' do
  user 'root'
  cwd '/home/vagrant'
  code <<-EOH
  sudo rm -rf /var/lib/tomcat/webapps/ROOT
  EOH
end
 
###copying and replacing existing ROOT.war with new ROOT.war in our cookbook files/default directory###
cookbook_file "/var/lib/tomcat/webapps/ROOT.war" do
  source "ROOT.war"
  mode "0644"
  notifies :restart, "service[tomcat]"
end
 
###restarting tomcat7 service###
service 'tomcat' do
  action :restart 
end
