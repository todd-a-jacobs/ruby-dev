class tmux {
    file { "/home/${mortal_user}/.tmuxrc":
      source    => 'puppet:///modules/tmux/.tmux.conf',
      ensure    => file,
      replace   => false,
      owner     => "${mortal_user}",
      group     => "${mortal_user}",
    }
}
