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
  sudo rm -rf /var/lib/tomcat/webapps/gameoflife-web-1.0-20170307.165122-1
  sudo rm -rf /var/lib/tomcat/webapps/gameoflife-web-1.0-20170307.165122-1.war
  sudo localectl set-locale LANG=en_IN.UTF-8
  sudo timedatectl set-timezone Asia/Kolkata
  EOH
end
 
###copying and replacing existing ROOT.war with new ROOT.war in our cookbook files/default directory###
remote_file '/var/lib/tomcat/webapps/sampleweb-1.0-20170324.172517-1.war' do
 source 'http://admin:admin@192.168.0.21:8081/nexus/content/repositories/snapshots/com/mycompany/sampleweb/1.0-SNAPSHOT/sampleweb-1.0-20170324.172517-1.war'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
  notifies :restart, "service[tomcat]"
end
 
###restarting tomcat7 service###
service 'tomcat' do
  action :restart 
end
