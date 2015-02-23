





class rea::passanger {
    FILE {
        owner   => 'root',
        group   => 'root',
    }

    case $::operatingsystem {
        'CentOS', 'RedHat': {
            $webserver = 'httpd'

            package {
                "$webserver":
                    ensure  => latest,
                    notify  => Exec['add_httpd_to_startup'];
                    
                ['git',  'ruby', 'rubygems', 'openssl']:
                    ensure  => latest;
                    
                'mod_passenger':
                    ensure      => latest;
                    
                'bundle':
                    ensure      => latest,
                    require     => Package['rubygems'],
                    provider    => 'gem';
            }
            
            service {
                'httpd':
                    ensure  => running,
                    require => Package["$webserver"];
            }
             exec {
                'add_httpd_to_startup':
                    command     => '/sbin/chkconfig httpd on',
                    refreshonly => true;
            }
        }
        
        'Ubuntu': {
            $webserver = 'apache2.2-common'
         
            package {
                ["$webserver", 'apache2-utils', 'apache2.2-bin']:
                    ensure  => latest,
                    notify  => Service['apache2'];
                ['ruby', 'rubygems', 'git']:
                    ensure  => latest;
                'libapache2-mod-passenger':
                    ensure  => latest,
                    notify  => Service['apache2'];
                'bundle':
                    ensure      => latest,
                    require     => Package['rubygems'],
                    provider    => 'gem';
            }
            service {
                'apache2':
                    ensure  => running,
                    require => Package["$webserver"];
            }
        }
        default: { fail('Unrecognized OS') }
    }
}
