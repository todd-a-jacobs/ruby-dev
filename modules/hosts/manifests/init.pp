class hosts {
    $new_host_name = 'vagrant'

    file {
      '/etc/hosts':
            ensure      => file,
            source      => 'puppet:///modules/hosts/hosts',
            replace     => false,
            mode        => 0644,
            owner       => root,
            group       => root,
    }

    host { $new_host_name:
        ensure => 'present',       
        target => '/etc/hosts',    
        ip => '127.0.1.1',         
        host_aliases => [],
    }
}
