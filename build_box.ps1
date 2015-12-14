
# Script Directory
if ($PSScriptRoot -eq $null) {
    $PSScriptRoot = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
}

# Configuration
. $PSScriptRoot\config.ps1

# CentOS Mirror
$mirrorurl="http://isoredirect.centos.org/centos/$($centos)/isos/$($arch)/"
$mirrorpage=Invoke-WebRequest $mirrorurl
$mirrorlist=$mirrorpage.Links | Where href -match "/$($centos)/isos/$($arch)/"
$mirrorurl=$mirrorlist[0].href

# Keyboard Layout
$keyboard=(Get-Culture).Name

# Bento/Packer
cd $PSScriptRoot\bento

$PSScriptRoot\packer\packer.exe build -only="$($provider)-iso" -var "keyboard=$($keyboard)" -var "mirror=$($mirrorurl)" -var "mirror_directory=''" centos-$($centos)-$($arch)-minimal.json

cd $PSScriptRoot

Read-Host "<Press Enter>"
