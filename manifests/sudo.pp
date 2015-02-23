








class rea::sudo {
    include rea::users
    file {
        '/etc/sudoers.d/admin':
           ensure  =>  present,
           mode    =>  '0644',
           owner   =>  'root',
           group   =>  'root',
           require =>  Group['coffeecoco'],
           source  =>  'puppet:///modules/rea/sudo/admin';
    }
             notify {"[+] set sudoers ":}               
    
}
