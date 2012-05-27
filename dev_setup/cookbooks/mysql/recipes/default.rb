#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2011, VMware
#
#

case node['platform']
when "ubuntu"
  package "mysql-client"

  bash "Setup mysql" do
    vs = node[:mysql][:version]
    passwd = node[:mysql][:server_root_password]
    code <<-EOH
    export DEBIAN_FRONTEND=noninteractive
    echo mysql-server-#{vs} mysql-server/root_password select #{passwd} | debconf-set-selections
    echo mysql-server-#{vs} mysql-server/root_password_again select #{passwd} | debconf-set-selections
    echo mysql-server-#{vs} mysql-server/db_root_password select #{passwd} | debconf-set-selections
    echo mysql-server-#{vs} mysql-server/db_root_password_again select #{passwd} | debconf-set-selections
    echo mysql-server-#{vs} mysql-server/db_root_password select true | debconf-set-selections
    echo mysql-server-#{vs} mysql-server/db_root_password_again select true | debconf-set-selections

    apt-get install -qqy mysql-server-#{vs}
    EOH
    not_if do
      ::File.exists?(File.join("", "usr", "sbin", "mysqld"))
    end
  end

  template File.join("", "etc", "mysql", "my.cnf") do
    source "ubuntu.cnf.erb"
    owner "root"
    group "root"
    mode "0600"
    notifies :restart, "service[mysql]"
  end

  service "mysql" do
    supports :status => true, :restart => true, :reload => true
    action [ :enable, :start ]
  end
else
  Chef::Log.error("Installation of mysql not supported on this platform.")
end
