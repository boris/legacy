remote_file '/tmp/telegraf_1.3.2-1_amd64.deb' do
  source 'https://dl.influxdata.com/telegraf/releases/telegraf_1.3.2-1_amd64.deb'
  owner 'root'
  group 'root'
  mode '0755'
end

dpkg_package 'telegraf_1.3.2-1_amd64' do
  action :install
  source '/tmp/telegraf_1.3.2-1_amd64.deb'
end

service 'telegraf' do
  supports :status => true, :restart => true
end
