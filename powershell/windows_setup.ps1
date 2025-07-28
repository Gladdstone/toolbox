# ------------------------------------------------------------------------
# Perform some basic Windows machine configuration
# ------------------------------------------------------------------------
PROFILE_PATH="$home\Documents\Powershell\Microsoft.PowerShell_profile.ps1"

wsl --update;
wsl --set-default-version 2;
wsl --install -d Ubuntu;
wsl --set-default Ubuntu;

# Install Chocolatey
# Set-ExecutionPolicy AllSigned;
Set-ExecutionPolicy Bypass -Scope Process -Force;
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'));

# Reload the session
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd $PWD"
exit

powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

choco install kubernetes-cli
kubectl version --client
mkdir ~/.kube
New-Item ~/.kube/config -type file

choco install k9s

mkdir ~/Code

# Bootstrap profile
# & "./add_to_startup.ps1 -Profile_Path $PROFILE_PATH"

Add-Content -Path $PROFILE_PATH -Value "kubectl completion powershell | Out-String | Invoke-Expression"

