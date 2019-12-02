apt_update 'update' do
  action :update
end

apt_package "grafana" do
  action :install
end

influxdb_install 'influxdb' do
  include_repository node['influxdb']['include_repo']
  install_version 
end
