execute "flush rules" do
  command "iptables -F"
end

node['listen'].each do |port|
  execute "add rules" do
    command "iptables -A INPUT -p tcp -s 0/0 --dport #{port} -j #{node["policy"]}"
  end
end

execute "deny all the rest" do
  command "iptables -A INPUT -p tcp -s 0/0 -j DROP"
end
