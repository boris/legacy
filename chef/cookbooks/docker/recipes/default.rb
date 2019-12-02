if node[:platform_family].include?("rhel")
  Chef::Log.info "Install dependencies"
  node['centos']['dependencies'].each do |pkg|
    package pkg
  end

  bash "Add docker repo" do
    code <<-EOH
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum-config-manager --enable docker-ce-edge
    EOH
  end
  Chef::Log.info "Install docker"
  package node['docker']['version']

  service 'docker' do
    action :start
  end
else
  bash "Add docker repo" do
    code <<-EOH
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    apt-key fingerprint 0EBFCD88
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    EOH
  end
  
  execute "apt update" do
    command "apt-get update"
  end
  
  Chef::Log.info "Install requirements"
  node['ubuntu']['requirements'].each do |pkg|
    package pkg
  end
  
  Chef::Log.info "Install dependencies"
  node['ubuntu']['dependencies'].each do |pkg|
    package pkg
  end

  Chef::Log.info "Install docker"
  package node['docker']['version']
end
