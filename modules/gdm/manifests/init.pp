class gdm {
    package { 'gdm': ensure => installed }

    # Automatic login using GDM.
    file {
        '/etc/gdm':
            ensure   => directory;
        '/etc/gdm/gdm.conf':
            backup   => '.puppet-bak',
            ensure   => present,
            owner    => 'root',
            group    => 'root',
            mode     => '644',
            content => "[daemon]\nAutomaticLoginEnable=true\nAutomaticLogin=${mortal_user}\n",
    }
}
