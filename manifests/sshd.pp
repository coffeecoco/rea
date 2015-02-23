







class rea::sshd {
    case $::operatingsystem {
        'CentOS', 'RedHat': {
           $service_name = 'sshd'
           $os_config = 'sshd_config.redhat'
        }
        'Ubuntu': {
           $service_name = 'ssh'
           $os_config = 'sshd_config.ubuntu'
        }
        default: { fail('Unrecognized operating system') }
    }
    file {
        '/etc/ssh/sshd_config':
           ensure  => present,
           owner   =>  'root',
           group   =>  'root',
           mode    =>  '0644',
           source  =>  "puppet:///modules/rea/sshd/${os_config}",
           notify  =>  Service["${service_name}"];
    }
    service {
        "${service_name}" :
           ensure      => running,
           hasrestart  => true;
   }
    notify {"[+] set ssh_config parameters  ":}               
    
}
