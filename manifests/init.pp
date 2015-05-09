class domaincontroller (
  $domainname = 'puppetlabs.demo',
  $safemodeadministratorpassword = 'Puppet10Labs',
  ){

  dism { [
    'ServerManager-Core-RSAT'
    'ServerManager-Core-RSAT-Role-Tools',
    'RSAT-AD-Tools-Feature',
    'RSAT-ADDS-Tools-Feature',
    'DNS-Server-Full-Role',
    'DNS-Server-Tools',
    'ActiveDirectory-Powershell',
    'DirectoryServices-DomainController',
    'DirectoryServices-DomainController-Tools',
  ]:
    ensure => 'present',
  }

  exec { 'Create Domain':
    command  => "install-addsforest -domainname $domainname -safemodeadministratorpassword ('$safemodeadministratorpassword' | convertto-securestring -asplaintext -force) -force",
    unless   => "get-adforest -identity $domainname",
    provider => 'powershell',
    require  => Dism['DirectoryServices-DomainController-Tools'],
  }

}
