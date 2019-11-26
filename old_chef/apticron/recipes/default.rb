#
# Cookbook Name:: apticron
# Recipe:: default
#
# Copyright 2013, Boris Quiroz
#
# All rights reserved - Do Not Redistribute
#
package "apticron" do
	action :install
end

template "/etc/apticron/apticron.conf" do
	source "apticron.conf.erb"
	owner "root"
	group "root"
	mode 0600
end
