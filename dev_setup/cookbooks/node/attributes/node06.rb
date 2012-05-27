include_attribute "deployment"
default[:node06][:version] = "0.6.17"
default[:node06][:path] = File.join(node[:deployment][:home], "deploy", "nodes", "node-#{node06[:version]}")
default[:node06][:source] = "http://nodejs.org/dist/v#{node06[:version]}/node-v#{node06[:version]}.tar.gz"

default[:node][:checksums]["0.6.17"] = "24974f8d07559e68dec2aaeb077dd52233b7d57e"
