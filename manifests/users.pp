#password: coffee
class rea::users {
    group {
        'coffeecoco':
            ensure  => present,
            gid     => '2222';
    }
    user {
        'coffee':
            ensure      => present,
            uid         => '3333',
            groups      => 'coffeecoco',
            password    => '$1$oGVtB7Es$xQFCfzzKsuTZT4y.wxDEB0',
            comment     => 'Coffee admin user group';
    }
         notify {"[+] created User/Group ":}               
    
}
