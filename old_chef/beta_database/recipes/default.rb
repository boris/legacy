#Ugly stuff.. :P

node[:beta_database][:databases].each do |db|

	execute "Mysql: Creating #{db.inspect}" do
		command <<-EOF 
			echo "CREATE DATABASE #{db['name']}; GRANT ALL ON #{db['name']}.* TO '#{db['user']}'@'%' IDENTIFIED BY '#{db['pass']}';" |
			mysql -u#{node[:beta_database][:admin_user]} -p#{node[:beta_database][:admin_password]}; 
			return 0
		EOF
	end
end
