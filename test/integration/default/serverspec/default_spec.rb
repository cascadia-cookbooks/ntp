require 'spec_helper'

describe 'cop_ntp::default' do
  case os[:family]
  when 'debian', 'ubuntu'
    service = 'ntp'
  when 'redhat', 'fedora'
    service = 'ntpd'
  end

  describe package(service) do
    it { should be_installed }
  end

  it 'the ntp service is enabled' do
    expect(service(service)).to be_enabled
  end

  it 'the ntp service is running' do
    expect(service(service)).to be_running
  end

  describe file('/etc/ntp.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode '644' }
    it { should contain('server ntp.colby.edu') }
  end

  it 'the ntp offset is below the limit' do
    offset = `ntpq -nc peers | tail -n +3 | cut -c 62-66 | tr -d '-' | tr -d ' ' | sort -nr | head -n1`.to_i
    expect(offset.to_i).to be <= 100
  end
end
