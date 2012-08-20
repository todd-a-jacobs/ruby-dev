class hosts {
    $new_host_name = "vagrant"

    file {
      '/etc/hosts':
            ensure      => file,
            source      => "puppet:///modules/hosts/hosts",
            replace     => false,
            owner       => root,
            group       => root;
            mode        => 0644,
    }

    host { $new_host_name:
        ensure => 'present',       
        target => '/etc/hosts',    
        ip => '127.0.1.1',         
        host_aliases => [],
    }
}
