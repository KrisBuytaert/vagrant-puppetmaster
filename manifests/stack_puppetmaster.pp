class stack_puppetmaster (
  $db            = false,
  $foreman       = false,
  $foreman_proxy = false,
  $puppetdb      = false,
  $puppetca      = false,
) {
  class { '::profile_puppet': }
  if $puppetca and ($foreman_proxy) {
    class { '::profile_foreman_proxy': }
    Class['::puppet'] ->
    Class['::foreman_proxy']
  }
  if $db {
    class { '::profile_postgresql': }
  }
  if $foreman {
    class { '::profile_foreman': }
    Class['::puppet'] ->
    Class['::foreman']
  }
  if $puppetdb {
    class { '::profile_puppetdb': }
    if ($puppetca) {
      Class['::puppet::server::service'] ->
      Class['::puppetdb::server']
    }
  }
}