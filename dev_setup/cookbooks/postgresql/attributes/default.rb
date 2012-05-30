default[:postgresql][:server_root_password] = "changeme"
default[:postgresql][:server_root_user] = "cloudfoundry"
default[:postgresql][:database] = "pg_service"
default[:postgresql][:index] = "0"
default[:postgresql][:version] = "9.1"

default[:postgresql_gateway][:node_timeout] = 2
default[:postgresql_gateway][:port] = nil
