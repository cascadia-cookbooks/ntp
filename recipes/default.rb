#
# Cookbook Name:: ntp
# Recipe:: default
# Author:: Copious Inc. <engineering@copiousinc.com>
#

include_recipe 'cop_ntp::dependencies'

ntp = node['ntp']['service']

node['ntp']['packages'].each do |p|
    package p do
        action :install
    end
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
    action [:enable,:start]
end

if node['ntp']['aggresive'] == true
    include_recipe 'cop_ntp::aggresive'
end
