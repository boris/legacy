# Dependencies
default['docker']['version'] = 'docker-ce'
default['ubuntu']['requirements'] = [
  'linux-image-extra-virtual'
]
default['centos']['dependencies'] = [
  'yum-utils',
  'device-mapper-persistent-data',
  'lvm2'
]
default['ubuntu']['dependencies'] = [
  'apt-transport-https',
  'ca-certificates',
  'curl',
  'software-properties-common'
]

# NFS Options
default['nfs']['dependencies'] = [
    'nfs-common'
]
default['nfs']['remote-path'] = '/mnt/docker'
default['nfs']['local-path'] = '/mnt/docker'
default['nfs']['server'] = '10.30.30.86'

# Users
default['docker']['users'] = [
  'ubuntu'
]
