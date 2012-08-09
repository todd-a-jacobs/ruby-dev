class keychain {
    package { 'keychain':
        ensure => installed,
    }
    line { 'keychain':
        file => "/home/${mortal_user}/.bashrc",
        line => 'eval $(keychain --eval --nogui --quick --ignore-missing id_rsa)';
    }
}
