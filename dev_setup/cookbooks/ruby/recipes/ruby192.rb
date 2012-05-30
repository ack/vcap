# convenience variables
ruby_version = node[:ruby192][:version]
ruby_source = node[:ruby192][:source]
ruby_path = node[:ruby192][:path]

cf_ruby_install(ruby_version, ruby_source, ruby_path)
