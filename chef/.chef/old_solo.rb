log_level :info
log_location STDOUT
file_cache_path "/var/chef/cache"
cookbook_path ["~/Code/chef/cookbooks", "{/Code/chef/custom-cookbooks}"]
data_bag_path "~/Code/chef/data_bags"
role_path "~/Code/chef/roles"
Mixlib::Log::Formatter.show_time = true
