apt_repository "php54" do
  uri "http://ppa.launchpad.net/ondrej/php5-oldstable/ubuntu"
  distribution "precise"
  components ["main"]
  key "E5267A6C"
  keyserver "keyserver.ubuntu.com"
  action :add
end

Chef::Log.info "packages: #{node['packages']}"
node['packages'].each do |pkg|
  package pkg
end
