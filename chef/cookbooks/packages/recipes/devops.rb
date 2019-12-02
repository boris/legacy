Chef::Log.info "packages: #{node['packages']}"
node['packages'].each do |pkg|
  package pkg
end
