bash "add repository" do
  code <<-EOH
  add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -  
  EOH
  not_if { File.exists?("/etc/postgresql/9.6/main/postgresql.conf") }
end

bash "apt update and install" do
  code <<-EOH
  apt-get update
  apt-get install -y postgresql-"#{node['postgres']['version']}"
  EOH
  not_if { File.exists?("/etc/postgresql/9.6/main/postgresql.conf") }
end

service 'postgresql' do
  supports :status => true, :restart => true
end

template "/etc/postgresql/9.6/main/postgresql.conf" do
  source "postgresql.conf.erb"
  mode '0644'
  owner 'postgres'
  group 'postgres'

  notifies :restart, 'service[postgresql]', :immediately
end
