default['listen'] = [
  '22',
  '80',
  '31337'
]
default['policy'] = 'ACCEPT'

if node.chef_environment == "production"
  default['user'] = 'boris'
else
  default['user'] = 'vagrant'
end
