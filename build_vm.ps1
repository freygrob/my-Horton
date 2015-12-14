
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
if (! Test-Path "$PSScriptRoot\vagrant\$vm\Vagrantfile") {
    Write-Host "Cloning $vm..."
    git clone https://github.com/my-Horton/$($vm).git "$PSScriptRoot\vagrant\$vm"
}

cd "$PSScriptRoot\vagrant\$vm"

vagrant box add centos-$($centos) "$PSScriptRoot\bento\builds\centos-$($centos)-$($arch)-minimal.$($provider).box"

Write-Host "Building $vm..."
vagrant up

cd "$PSScriptRoot"

if ($Host.Name -eq "ConsoleHost") {
    Read-Host "<Press Enter>"
}
