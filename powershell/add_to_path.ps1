# ------------------------------------------------------------------------
# append a value to the path
# ------------------------------------------------------------------------

param(
    (string)$NewPath
)

if (-not ($Env:PATH -split ";" | ForEach-Object { $_.Trim() } | Where-Object { $_ -eq $NewPath })) {
    [Environment]::SetEnvironmentVariable("PATH", $Env:PATH + ";$NewPath", "User")
}

