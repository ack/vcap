module RubyInstall
  def cf_ruby_install(ruby_version, ruby_source, ruby_path)
    rubygems_version = node[:rubygems][:version]
    bundler_version = node[:rubygems][:bundler][:version]
    rake_version = node[:rubygems][:rake][:version]

    %w[ build-essential libssl-dev zlib1g-dev libreadline*-dev libxml2-dev libpq-dev libyaml-dev ].each do |pkg|
      package pkg
    end

    tarball_path = File.join(node[:deployment][:setup_cache], "ruby-#{ruby_version}.tar.gz")
    cf_remote_file tarball_path do
      owner node[:deployment][:user]
      source ruby_source
      checksum node[:ruby][:checksums][ruby_version]
    end

    directory ruby_path do
      owner node[:deployment][:user]
      group node[:deployment][:group]
      mode "0755"
      recursive true
      action :create
    end


    file "/tmp/ruby-openssl.patch" do
      action :create
      content <<-EOS
*** ext/openssl/ossl_ssl.c	2012-04-06 20:21:24.037445894 -0700
--- ext/openssl/ossl_ssl.c	2012-04-06 20:29:47.262793676 -0700
*************** struct {
*** 107,115 ****
--- 107,117 ----
      OSSL_SSL_METHOD_ENTRY(TLSv1),
      OSSL_SSL_METHOD_ENTRY(TLSv1_server),
      OSSL_SSL_METHOD_ENTRY(TLSv1_client),
+ /*
      OSSL_SSL_METHOD_ENTRY(SSLv2),
      OSSL_SSL_METHOD_ENTRY(SSLv2_server),
      OSSL_SSL_METHOD_ENTRY(SSLv2_client),
+ */
      OSSL_SSL_METHOD_ENTRY(SSLv3),
      OSSL_SSL_METHOD_ENTRY(SSLv3_server),
      OSSL_SSL_METHOD_ENTRY(SSLv3_client),
EOS
    end


    bash "Install Ruby #{ruby_path}" do
      cwd File.join("", "tmp")
      user node[:deployment][:user]
      code <<-EOH
      # work around chef's decompression of source tarball before a more elegant
      # solution is found
      tar xzf #{tarball_path}
      cd ruby-#{ruby_version}

      if [ "#{ruby_version}" != "1.9.3-p125" ] ; then
        patch -p0 < /tmp/ruby-openssl.patch
      fi

      ./configure --disable-pthread --prefix=#{ruby_path} --disable-install-doc  --disable-install-rdoc
      make
      make install
      EOH
      not_if do
        ::File.exists?(File.join(ruby_path, "bin", "ruby"))
      end
    end

    cf_remote_file File.join("", "tmp", "rubygems-#{rubygems_version}.tgz") do
      owner node[:deployment][:user]
      source "http://production.cf.rubygems.org/rubygems/rubygems-#{rubygems_version}.tgz"
      checksum node[:rubygems][:checksum]
      not_if { ::File.exists?(File.join("", "tmp", "rubygems-#{rubygems_version}.tgz")) }
    end

    bash "Install RubyGems #{ruby_path}" do
      cwd File.join("", "tmp")
      user node[:deployment][:user]
      code <<-EOH
      tar xzf rubygems-#{rubygems_version}.tgz
      cd rubygems-#{rubygems_version}
      #{File.join(ruby_path, "bin", "ruby")} setup.rb
      EOH
      not_if do
        ::File.exists?(File.join(ruby_path, "bin", "gem")) &&
            system("#{File.join(ruby_path, "bin", "gem")} -v | grep -q '#{rubygems_version}$'")
      end
    end

    gem_package "bundler" do
      version bundler_version
      gem_binary File.join(ruby_path, "bin", "gem")
    end

    gem_package "rake" do
      version rake_version
      gem_binary File.join(ruby_path, "bin", "gem")
    end

    # The default chef installed with Ubuntu 10.04 does not support the "retries" option
    # for gem_package. It may be a good idea to add/use that option once the ubuntu
    # chef package gets updated.
    %w[ rack eventmachine thin sinatra mysql pg vmc ].each do |gem|
      gem_package gem do
        gem_binary File.join(ruby_path, "bin", "gem")
      end
    end
  end
end

class Chef::Recipe
  include RubyInstall
end
