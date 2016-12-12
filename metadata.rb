name 'cop_ntp'
maintainer 'Copious Inc.'
maintainer_email 'engineering@copiousinc.com'
license 'MIT'
description 'Installs and configures NTP.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'

source_url 'https://github.com/copious-cookbooks/ntp'
issues_url 'https://github.com/copious-cookbooks/ntp/issues'

supports 'ubuntu'
supports 'debian'
supports 'centos'

depends 'cop_base'
