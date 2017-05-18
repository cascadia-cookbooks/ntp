#
# Cookbook Name:: cop_ntp
# Recipe:: aggressive
# Author:: Copious Inc. <engineering@copiousinc.com>
#

ntp = node['ntp']['service']

ruby_block 'check ntp offset' do
    block do
        node.default['ntp']['worst_offset'] = `ntpq -nc peers | tail -n +3 | cut -c 62-66 | tr -d '-' | tr -d ' ' | sort -nr | head -n1`.to_i
    end
end

log 'offset warning' do
    message lazy { "NTP time offset (#{node['ntp']['worst_offset']}) is greater the configured limit (#{node['ntp']['offset_limit']})" }
    level :warn
    action :nothing
end

execute "correcting ntp offset" do
    command 'ntpd -gq && sleep 2'
    action   :run
    notifies :write, "log[offset warning]", :before
    notifies :stop, "service[#{ntp}]", :before
    notifies :start, "service[#{ntp}]", :delayed
    only_if { node['ntp']['worst_offset'] > node['ntp']['offset_limit'] }
end
