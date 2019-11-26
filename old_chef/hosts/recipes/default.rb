#
# Cookbook Name:: hosts
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
hosts = search(:node, "*:*", "X_CHEF_id_CHEF_X asc")

template "/etc/hosts" do
  source "hosts.erb"
        owner "root"
        group "root"
        mode 0644
        variables(
          :hosts => hosts,
                :fqdn => node[:fqdn],
                :hostname => node[:hostname]
        )
end
