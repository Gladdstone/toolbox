<#
# build and push docker image to specified registry
#>
param(
  [string]$registry
)

$buildOutput = docker build -q .

if ($LASTEXITCODE -eq 0) {
    $imageSHA = $buildOutput.Trim()
    Write-Host "Image built successfully. SHA: $imageSHA"
} else {
    Write-Host "Docker build failed"
    exit 1
}

docker tag $imageSHA $registry
docker push $registry

