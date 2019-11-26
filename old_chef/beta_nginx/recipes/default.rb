#Custom wrapper for nginx!

include_recipe "beta_nginx::conf.d"
include_recipe "beta_nginx::includes_server"

service 'nginx' do
  supports :status => true, :restart => true, :reload => true
  action :restart
end
