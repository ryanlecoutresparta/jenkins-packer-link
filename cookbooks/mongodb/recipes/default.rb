#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
apt_update 'update' do
  action :update
end

apt_repository 'mongodb-org' do
  uri "http://repo.mongodb.org/apt/ubuntu"
  distribution "xenial/mongodb-org/3.2"
  components ['multiverse']
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "EA312927"
end

package 'mongodb-org' do
  action :upgrade
end

service 'mongod' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

link '/etc/mongod/mongod.conf' do
  action :delete
end

link '/etc/systemd/system/mongod.service' do
  action :delete
end

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  notifies :restart, 'service[mongod]'
end

template '/etc/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  notifies :restart, 'service[mongod]'
end
