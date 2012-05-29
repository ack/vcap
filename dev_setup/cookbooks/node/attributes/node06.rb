include_attribute "deployment"
default[:node06][:version] = "0.6.17"
default[:node06][:path] = File.join(node[:deployment][:home], "deploy", "nodes", "node-#{node06[:version]}")
default[:node06][:source] = "http://nodejs.org/dist/v#{node06[:version]}/node-v#{node06[:version]}.tar.gz"

default[:node][:checksums]["0.6.17"] = "8dfe5948de27e37a14af184f06e7bd89a23c3b248af44c8ef5cffcd0e4c65778"
