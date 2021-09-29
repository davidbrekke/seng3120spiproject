# -*- mode: ruby -*-
# vi: set ft=ruby :
# 
# Author: David Magnuson
# 

Vagrant.configure("2") do |config|
  
  # WEB server
  config.vm.define "web" do |web|

    # ubing ubuntu os
    web.vm.box = "ubuntu/bionic64"

    # forward the ports and give private ip
    web.vm.network "forwarded_port", guest: 80, host: 80
    web.vm.network "private_network", ip: "192.168.56.10"

    # provision the web server to run shell script on start
    web.vm.provision :shell, :path => "./web.sh"

  end # END WEB

  # DB server
  config.vm.define "db" do |db|

    # ubing ubuntu os
    db.vm.box = "ubuntu/bionic64"

    # give private ip
    db.vm.network "private_network", ip: "192.168.56.11"

    # provision the db server to run shell script on start
    db.vm.provision :shell, :path => "./db.sh", :args => "db_name username password"

    db.vm.provision :file, :source => "./mysqld.cnf", :destination => "/home/vagrant/etc/mysql/mysql.conf.d/mysqld.cnf"

  end # END DB

end # END CONFIG
