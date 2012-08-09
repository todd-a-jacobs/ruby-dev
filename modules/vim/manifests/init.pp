class vim {

  $packages = [
    exuberant-ctags,
    ispell,
    vim,
    vim-addon-manager,
    vim-puppet,
    vim-rails,
    vim-scripts,
  ]
  package { $packages: ensure => installed, }

  $file = "/home/${mortal_user}/.bashrc"
  line {
    'EDITOR':
      file    => "$file",
      line    => 'export EDITOR="/usr/bin/vim"';
    'VISUAL':
      file    => "$file",
      line    => 'export VISUAL="$EDITOR"';
  }

  file { "/home/${mortal_user}/.vimrc":
    ensure    => file,
    replace   => false,
    owner     => "${mortal_user}",
    group     => "${mortal_user}",
    source => 'puppet:///modules/vim/.vimrc';
  }
}
