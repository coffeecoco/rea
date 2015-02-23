
Assumptions:
1. deployment scripts done for agent to communicate to Master.
2. The new server have one of the followings OSs RedHat, CentOS or Ubuntu 
3. The new server get it IP and DNS setting from DHCP.
4. The new server have access to the internet for downloading required packages and ruby gems.



How to use this module
1. Add the server to puppet master server.
2. Configure the new server to receive this module by adding the following to the node config:
   node 'node1' {
       include rea
   }
4. run the puppet agent on the new server.

This  will do the following:
1. Will create a static user with full sudo permissions.
2. Will create a static group.
3. Will disable selinux.
4. Will set the iptables firewall to start at boot with the following settings:
5. Install httpd and mod_passenger via RPM/DEB packages.
6. Pull the simple-sinatra-app from github, install require ruby gems and configure httpd server to server it on port 80.


notes:
Make more modular "lego blocks"
Fix up params and centralize parameters for diff OS
small local issue with gem install bundler
should add git pull updater if files exist and handle errors

Tested on:
CentOS 6.5 i686 
Ubuntu 12.04 LTS x64
