# == Class: slack
#
# manage slack desktop client
#
# === Examples
#
# include slack
#
class slack {
  case $::operatingsystem {
    'Fedora': {
      $pkg_name = 'slack'
      $pkg = "${pkg_name}-2.0.6-0.1.fc21.x86_64.rpm"
      $provider = 'rpm'
      $deps = ['libXScrnSaver']
    }
    'Ubuntu': {
      $pkg_name = 'slack-desktop'
      $pkg = "${pkg_name}-2.0.6-amd64.deb"
      $provider = 'dpkg'
      $deps = [
				'libxss1',
				'gconf2',
				'gconf-service',
				'libgtk2.0-0',
				'libnotify4',
				'libxtst6',
				'libnss3',
				'gvfs-bin',
				'xdg-utils',
				'apt-transport-https',
			]
    }
    default: {
      fail("unsupported operatingsystem: ${::operatingsystem}")
    }
  }

  $download_url = "https://downloads.slack-edge.com/linux_releases/${pkg}"

	$path = '/opt/slack'

	file { $path:
		ensure => directory,
	}

	archive { $pkg:
		source  => $download_url,
		path    => "${path}/$pkg",
		cleanup => false,
		extract => false,
		require => File[$path],
	}

  if $deps {
    ensure_packages($deps)
    Package[$deps] -> Package[$pkg_name]
  }

  package { $pkg_name:
    ensure   => present,
    source   => "${path}/$pkg",
    provider => $provider,
    require  => Archive[$pkg],
  }
}
