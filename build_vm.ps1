
# Script Directory
if ($PSScriptRoot -eq $null) {
    $PSScriptRoot = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
}

# Configuration
. $PSScriptRoot\config.ps1

# Vagrant
cd $PSScriptRoot\vagrant

vagrant box add centos-$($centos) $PSScriptRoot\bento\builds\centos-$($centos)-$($arch)-minimal.$($provider).box

vagrant up

cd $PSScriptRoot

Read-Host "<Press Enter>"
