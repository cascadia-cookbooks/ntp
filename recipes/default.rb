#
# Cookbook Name:: ntp
# Recipe:: default
# Author:: Copious Inc. <engineering@copiousinc.com>
#

case node['platform_family']
when 'ubuntu', 'debian'
    include_recipe 'apt'
when 'rhel', 'centos'
    include_recipe 'yum'
end

ntp = node['ntp']['service']

node['ntp']['packages'].each do |package|
    package package do
        action :install
    end
end

if node['ntp']['aggresive'] == true
    include_recipe 'cop_ntp::aggresive'
end

template 'installing ntp config file' do
    path      '/etc/ntp.conf'
    cookbook  'cop_ntp'
    source    'default/ntp.conf.erb'
    owner     'root'
    group     'root'
    mode      0644
    backup    false
    action    :create
    notifies  :restart, "service[#{ntp}]", :delayed
    variables ({
        :options => node['ntp']['options']
    })
end

service ntp do
    action :enable
end