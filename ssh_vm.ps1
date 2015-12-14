
# Script Directory
if ($PSScriptRoot -eq $null) {
    $PSScriptRoot = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
}

# Configuration
. $PSScriptRoot\config.ps1

# ssh
$env:Path += ";C:\Program Files\Git\usr\bin"

# Vagrant SSH
cd $PSScriptRoot\vagrant

vagrant ssh
if (! $? -or $LastExitCode -ne 0) {
    Read-Host "<Press Enter>"
}

cd $PSScriptRoot
