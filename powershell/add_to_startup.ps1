<#
# Add a script to execute on powershell profile load
#>
param(
  (string)$Filepath
  (string)$Profile_Path = "$home\Documents\Powershell\Microsoft.PowerShell_profile.ps1"
)

if (!(Test-Path)) {
  Write-Output "Generating a new ps profile..."
  New-item -type file -force $profile
}

Add-Content -Path $Profile_Path -Value "$Filepath"
& $profile

