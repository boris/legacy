template "/etc/apache2/sites-enabled/lineaetica.conf" do
  source "sites/lineaetica.erb"
  mode '0644'
  owner 'root'
  group node['apache']['root_group']
end
