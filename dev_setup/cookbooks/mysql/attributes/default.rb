default[:mysql][:server_root_password] = "mysql"
default[:mysql][:server_root_user] = "root"
default[:mysql][:host] = "localhost"
default[:mysql][:version] = "5.5"

default[:mysql_gateway][:node_timeout] = 2
default[:mysql_gateway][:port] = nil

default[:mysql_node][:capacity] = "50"
default[:mysql_node][:index] = "0"
default[:mysql_node][:max_db_size] = "20"
default[:mysql_node][:token] = "changemysqltoken"
