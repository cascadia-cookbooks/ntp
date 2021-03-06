# NTP Cookbook
This will configure the NTP service. It can also correct time offsets.

## Platforms
- Ubuntu 
- Debian
- Rhel
- Fedora

## Attributes
* `node['ntp']['aggressive']` (boolean) defaults to `true`, when `true` it will stop the NTP
  service and correct the offset if its above the offset limit on each Chef run
* `node['ntp']['offset_limit']` (int) defaults to `100`, maximum offset time in milliseconds
* `node['ntp']['servers']` (hash) servers to poll for ntp queries

## Usage
Here's an example `base` role that have some NTP configs.

```ruby
name 'base'
description 'things for our base image!'

override_attributes(
    ...
    'ntp' => {
        'aggressive'   => true,
        'offset_limit' => 100,
        'servers'      => %w(
            1.north-america.pool.ntp.org
            tick.ucla.edu
            ntp.colby.edu
        )
    }
    ...
)

run_list(
    '..., recipe[cop_ntp], ...'
)
```

NOTE: You will be required to include a `depends` for this cookbook inside YOUR cookbook's `metadata.rb` file.

```ruby
...
depends 'cop_ntp', git: 'git@github.com:copious-cookbooks/ntp.git'
...
```
