class rea::simple_sinatra_app {
FILE {
        owner   =>  'root',
        group   =>  'root',
    }
    
    include rea::passanger
    
exec {
        'git_clone_sinatra-app':
            command     =>  '/usr/bin/git clone https://github.com/tnh/simple-sinatra-app.git /opt/simple-sinatra-app',
#            refreshonly => true,
            require     => Package['git'],
            notify      => Exec['bundle_install_gem'],
	   creates      => "/opt/simple-sinatra-app/Gemfile",
   }    

file {
                '/opt/simple-sinatra-app/helloworld.rb':
                    ensure  => present,
                    owner   => 'root',
                    group   => 'root',
                    mode    => '0644',
                    source  => 'puppet:///modules/rea/msg/helloworld.rb',
#                    notify  => Service["$httpd_svc"];
		    notify  => Class['rea::service'],

     }     
    notify {"[+] git clone ":}
    
exec {
        'bundle_install_gem':
            command     => '/usr/local/bin/bundle install --gemfile /opt/simple-sinatra-app/Gemfile',
            refreshonly => true,
            require     => [Package['bundle'],Exec['git_clone_sinatra-app']];
    }
     notify {"[+] bundle install gemfile ":}   
    
file {
        '/var/www/simple-sinatra-app':
            ensure  => directory,
            mode    => '0755',
            owner   =>  'root',
            group   =>  'root',
            require => Package["$rea::passanger::webserver"];
    
        '/var/www/simple-sinatra-app/public':
            ensure  => symlink,
            target  => '/opt/simple-sinatra-app/',
            require => File['/var/www/simple-sinatra-app'],
    }
     notify {"[+] symlink ":}               
    
case $::operatingsystem {
        'CentOS', 'RedHat': {
            file {
                '/etc/httpd/conf.d/rea.conf':
                    ensure  => present,
                    mode    => '0644',
                    owner   =>  'apache',
                    group   =>  'apache',
                    require => [Package['httpd'],File['/var/www/simple-sinatra-app/public']],
                    content => template('rea/httpd/rea.erb'),
                    notify  => Service['httpd'];
                    #notify  => Service[$rea::httpd_svc],
                        
                    
    }
     notify {"[+] rea.conf.erb template for RedHat ":}               
            
        }
        'Ubuntu':{
            file {
                '/etc/apache2/sites-available/000-default.conf':
                    ensure  => absent,
                    notify  => Service['apache2'];
                 '/etc/apache2/sites-enabled/000-default.conf':
                    ensure  => absent,
                    notify  => Service['apache2'];
                '/etc/apache2/sites-available/rea.conf':
                    ensure  => present,
                    mode    => '0644',
                    owner   =>  'www-data',
                    group   =>  'www-data',
                    require => [Package['apache2.2-common'],File['/var/www/simple-sinatra-app/public']],
                    notify  => File['/etc/apache2/sites-available/000-default.conf'],
                    content => template('rea/httpd/rea.erb');
                '/etc/apache2/sites-enabled/rea.conf':
                    ensure  => symlink,
                    target  => '/etc/apache2/sites-available/rea.conf',
                    require => File['/etc/apache2/sites-available/rea.conf'],
                    notify  => Service['apache2'];
            }
             notify {"[+] rea.conf.erb template for Ubuntu ":}               
        }
        default: { fail('Unrecognized OS') }
    }
}
