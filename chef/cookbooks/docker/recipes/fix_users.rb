Chef::Log.info "Add users to docker group"
node['docker']['users'].each do |user|
  execute "usermod -a -G" do
    command "usermod -a -G docker #{user}"
  end
end
