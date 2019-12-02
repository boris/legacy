#
# Cookbook Name:: cx_Oracle
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "yum install" do
  code <<-EOH
  yum -y groupinstall 'Development Tools'
  yum -y install python-devel
  EOH
  not_if { File.exists?("/usr/bin/gcc") }
end

execute "Download Oracle packages" do
  command "wget -P /tmp http://192.168.0.9:8000/instantclient-sdk-linux.x64-12.1.0.2.0.zip && wget -P /tmp http://192.168.0.9:8000/instantclient-basic-linux.x64-12.1.0.2.0.zip"
  not_if { File.directory?("/opt/oracle") }
end

bash "Oracle setup" do
  code <<-EOH 
  mkdir -p /opt/oracle
  unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle
  unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle
  EOH
  not_if { File.directory?("/opt/oracle/instantclient_12_1") }
end

bash "Configure Oracle client" do
  cwd "/opt/oracle/instantclient_12_1"
  code <<-EOH
  ln -s libclntsh.so.12.1 libclntsh.so
  wget -P /tmp https://bootstrap.pypa.io/get-pip.py
  python /tmp/get-pip.py
  EOH
end

bash "Install cx_Oracle" do
  code <<-EOH
  export LD_RUN_PATH=/opt/oracle/instantclient_12_1
  export ORACLE_HOME=/opt/oracle/instantclient_12_1
  pip install cx_Oracle
  EOH
end
