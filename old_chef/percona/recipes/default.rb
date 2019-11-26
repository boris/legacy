#
# Cookbook Name:: percona
# Recipe:: default
#
# Copyright 2013, Betazeta
#
# All rights reserved - Do Not Redistribute
#
node[:btz_database][:database].each do |db|
	execute "Mysql: Creating #{db.inspect}" do
		echo "CREATE DATABASE #{db['name']}; GRANT ALL ON #{db['name']}.* TO '#{db['user']}'@'%' IDENTIFIED BY '#{db['pass']}';" |
		mysql -u#{node[:btz_database][:admin_user]} -p#{node[:btz_database][:admin_password]};
		return 0
		EOF
	end
end
