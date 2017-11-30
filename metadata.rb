name 'cop_ntp'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures NTP.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.1.1'

source_url 'https://github.com/copious-cookbooks/ntp'
issues_url 'https://github.com/copious-cookbooks/ntp/issues'

supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 8.0'
supports 'redhat', '>= 7.0'
supports 'centos', '>= 7.0'

depends 'cop_base'
