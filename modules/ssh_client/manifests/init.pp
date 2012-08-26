class ssh_client {
    File {
        ensure  => file,
        owner   => "${mortal_user}",
        group   => "${mortal_user}",
        mode    => 0600,
        recurse => false,
        replace => false,
    }

    file {
        "/home/${mortal_user}/.ssh/known_hosts":
            source  => 'puppet:///modules/ssh_client/known_hosts';
        "/home/${mortal_user}/.ssh/config":
            source  => 'puppet:///modules/ssh_client/config';
    }
}
