execute "apt update" do
    command "apt-get update"
end

Chef::Log.info "Install nfs-common"
node['nfs']['dependencies'].each do |pkg|
    package pkg
end

# Add to fstab and mount
bash "Add NFS to fstab and mount" do
    code <<-EOC
    mkdir /mnt/docker
    echo '10.30.30.86:/mnt/docker /mnt/docker     nfs     defaults        0 0' >> /etc/fstab
    mount -a
    EOC
end

