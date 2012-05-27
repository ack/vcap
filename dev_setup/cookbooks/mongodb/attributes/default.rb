include_attribute "deployment"
default[:mongodb][:version] = "1.8.1"
default[:mongodb][:source] = "http://fastdl.mongodb.org/linux/mongodb-linux-#{node[:kernel][:machine]}-#{mongodb[:version]}.tgz"
default[:mongodb][:path] = File.join(node[:deployment][:home], "deploy", "mongodb")
default[:mongodb][:checksums]["x86_64"] = "8f6a58293068e0fb28b463b955f3660f492094e53129fb88af4a7efcfc7995da"
default[:mongodb][:checksums]["i686"] = "19415154974d62e745977e1bc01e24c0ca3b9d1149881da255315fb4f1cfbf31"

default[:mongodb_node][:capacity] = "50"
default[:mongodb_node][:index] = "0"
default[:mongodb_node][:max_memory] = "128"
default[:mongodb_node][:token] = "changemongodbtoken"
