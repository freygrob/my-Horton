
Param {
    [string]$vm = "my-Ambari"
}

# Script Directory
if ($PSScriptRoot -eq $null) {
    $PSScriptRoot = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
}

# Configuration
. "$PSScriptRoot\config.ps1"

# Vagrant
cd "$PSScriptRoot\vagrant\$vm"

Write-Host "Building $vm..."

vagrant box add centos-$($centos) "$PSScriptRoot\bento\builds\centos-$($centos)-$($arch)-minimal.$($provider).box"

vagrant up

cd "$PSScriptRoot"

if ($Host.Name -eq "ConsoleHost") {
    Read-Host "<Press Enter>"
}
