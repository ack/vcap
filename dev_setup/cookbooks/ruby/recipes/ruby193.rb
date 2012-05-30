# convenience variables
ruby_version = node[:ruby193][:version]
ruby_source = node[:ruby193][:source]
ruby_path = node[:ruby193][:path]

cf_ruby_install(ruby_version, ruby_source, ruby_path)
