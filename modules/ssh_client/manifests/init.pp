class ssh_client {

file { "/home/${mortal_user}/.ssh/known_hosts":
    ensure  => file,
    owner   => "${mortal_user}",
    group   => "${mortal_user}",
    mode    => 0600,
    recurse => false,
    replace => false,
    source  => 'puppet:///modules/ssh_client/known_hosts',   
}
