include_recipe "users::sysadmins"

users_manage 'sysadmins' do
  group_id 1101
  action [:create]
  data_bag 'users'
end
