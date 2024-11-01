<#
# Add a script to execute on powershell profile load
#>
param(
  (string)$filepath
)

if (!(Test-Path)) {
  Write-Output "Generating a new ps profile..."
  New-item -type file -force $profile
}

Add-Content -Path "$home\Documents\Powershell\Microsoft.PowerShell_profile.ps1" -Value "$filepath"
& $profile

