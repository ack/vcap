include_attribute "deployment"
default[:ruby193][:version] = "1.9.3-p125"
default[:ruby193][:source]  = "http://ftp.ruby-lang.org//pub/ruby/1.9/ruby-#{ruby193[:version]}.tar.gz"
default[:ruby193][:path]    = File.join(node[:deployment][:home], "deploy", "rubies", "ruby-#{ruby193[:version]}")
default[:ruby][:checksums]["1.9.3-p125"] = "8b3c035cf4f0ad6420f447d6a48e8817e5384d0504514939aeb156e251d44cce"

default[:rubygems][:version] = "1.8.24"
default[:rubygems][:bundler][:version] = "1.1.3"
default[:rubygems][:rake][:version] = "0.8.7"
default[:rubygems][:checksum] = "4b61fa51869b3027bcfe67184b42d2e8c23fa6ab17d47c5c438484b9be2821dd"
