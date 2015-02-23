
# attempt here to create parameters that work on diff distros
    include rea::users
    include rea::sudo
    include rea::sshd
    include rea::selinux
    include rea::firewall
    include rea::passanger
    include rea::simple_sinatra_app
    #include rea::global
   # include rea::params

class rea ($docroot = undef,
 $httpd_user    = $rea::params::httpd_user,
 $httpd_group   = $rea::params::httpd_group,
 $httpd_pkg     = $rea::params::httpd_pkg,
 $httpd_svc     = $rea::params::httpd_svc,
 $httpd_conf    = $rea::params::httpd_conf,
 $httpd_confdir = $rea::params::httpd_confdir,
 ) inherits rea::params {


 

}