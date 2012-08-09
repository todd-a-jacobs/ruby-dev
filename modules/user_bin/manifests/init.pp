class user_bin {
    file { "/home/${mortal_user}/bin":
	    source  => 'puppet:///modules/user_bin/',	
	    recurse => true,
            owner   => "${mortal_user}",
            group   => "${mortal_user}";
    }
}
