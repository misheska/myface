name             'myface'
maintainer       'Mischa Taylor'
maintainer_email 'mischa@misheska.com'
license          'Apache 2.0'
description      'Installs/Configures myface'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.0'

depends "apache2", "~> 1.7.0"
depends "mysql", "~> 3.0.0"
depends "database", "~> 1.4.0"
depends "php", "~> 1.2.0"
