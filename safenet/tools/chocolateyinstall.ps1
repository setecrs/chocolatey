$packageName = 'safenet'
$innerName = 'SafeNetAuthenticationClient-x32-x64-9.0.exe'
$url = 'http://repositorio.serpro.gov.br/drivers/safenet/Driver_Safenet_Windows_32bits_64bits.zip'
$fileType = 'zip'

$chocTempDir = $env:TEMP
$tempDir = Join-Path $chocTempDir "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}
$file = Join-Path $tempDir "$($packageName)Install.$fileType"

Get-ChocolateyWebFile $packageName $file $url 
Get-ChocolateyUnzip $file $tempDir
Install-ChocolateyInstallPackage $packageName 'exe' '/qb' $tempDir/$innerName
