#
# Cookbook Name:: ntp
# Recipe:: dependencies
# Author:: Copious Inc. <engineering@copiousinc.com>
#

case node['platform_family']
when 'debian'
    include_recipe 'apt::default'
when 'rhel'
    # NOTE: EPEL (Extra Packages for Enterprise Linux)
    package 'epel-release' do
        action :install
    end
when 'fedora'
    # NOTE: workaround for lack of Chef DNF provider on fedora >= 19
    execute 'dnf install -y yum' do
        command 'dnf install -y yum'
        only_if 'test -f /usr/bin/dnf'
        creates '/usr/bin/yum-deprecated'
    end
end
