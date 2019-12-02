#
# Cookbook Name:: packages
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
Chef::Log.info "packages: #{node['packages']}"
node['packages'].each do |pkg|
  package pkg
end

Chef::Log.info "packages: #{node['packages_web']}"
node['packages_web'].each do |pkg|
  package pkg
end
