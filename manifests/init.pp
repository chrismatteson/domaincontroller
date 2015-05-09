class domaincontroller (
  $domainname = 'puppetlabs.demo',
  $safemodeadministratorpassword = 'Puppet10Labs',
  ){

  dism { [
    'RSAT-ADDS-Tools-Feature',
    'DirectoryServices-DomainController',
    'DirectoryServices-DomainController-Tools',
    'DNS-Server-Full-Role',
    'DNS-Server-Tools',
    'ActiveDirectory-Powershell',
    'RSAT-AD-Tools-Feature',
    'ServerManager-Core-RSAT-Role-Tools',
    'ServerManager-Core-RSAT'
  ]:
    ensure => 'present',
  }

  exec { 'Create Domain':
    command  => "install-addsforest -domainname $domainname -safemodeadministratorpassword ('$safemodeadministratorpassword' | convertto-securestring -asplaintext -force) -force",
    unless   => "get-adforest -identity $domainname",
    provider => 'powershell',
  }

}
