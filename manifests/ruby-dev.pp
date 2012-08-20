#!/usr/bin/env puppet
# vim: sw=4 et ai tw=132

$root_path = '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
$getconf_path = '/bin:/usr/bin'
$mortal_user = 'vagrant'

stage { 'first': before => Stage['main'] }
stage { 'last': require => Stage['main'] }

define line($file, $line, $ensure = 'present') {
  case $ensure {
    default : { err ( "unknown ensure value ${ensure}" ) }
      present: {
        exec { "/bin/echo '${line}' >> '${file}'":
          unless => "/bin/grep -qFx '${line}' '${file}'"
        }
      }
      absent: {
        exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}' > /dev/null 2>&1":
          onlyif => "/bin/grep -qFx '${line}' '${file}'"
        }
      }
  }
}

class {'apt_clean': stage => last, }
class {'apt_config': stage => first, }
class {'apt_utils': }
class {'awesome': }
class {'browsers': }
class {'gdm': }
class {'git': }
class {'grep': }
class {'hosts': }
class {'keychain': }
class {'lxde': }
class {'make_sandbox_directory': }
class {'markup': }
class {'misc_packages': }
class {'puppet': stage => first, }
class {'sshd': }
class {'synchronization': }
class {'user_bin': }
class {'vim': }
class {'virtualbox_guest_additions': }
class {'virtual_displays': }
