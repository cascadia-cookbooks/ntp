case node['platform_family']
when 'ubuntu', 'debian'
    default['ntp']['service']    = 'ntp'
    default['ntp']['drift_file'] = '/var/lib/ntp/ntp.drift'
when 'rhel', 'centos', 'fedora'
    default['ntp']['service']     = 'ntpd'
    default['ntp']['drift_file']  = '/var/lib/ntp/drift'
    default['ntp']['secure_opts'] = true
end

default['ntp']['packages']     = %w{ntp ntpdate}
default['ntp']['aggressive']   = true
default['ntp']['offset_limit'] = 100

default['ntp']['servers'] = %w{
    0.north-america.pool.ntp.org
    1.north-america.pool.ntp.org
    tick.ucla.edu
    ntp.colby.edu
}
