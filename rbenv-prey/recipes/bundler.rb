log "installing bundler for rbenv local"
execute "gem install bundler" do
   cwd "/home/#{node["user"]}"
   command "su #{node["user"]} -c '~/.rbenv/shims/gem install bundler'"
   action :run
end
