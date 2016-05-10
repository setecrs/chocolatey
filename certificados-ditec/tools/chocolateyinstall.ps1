$packageName = 'certificados-ditec'
$baseUrl = 'http://ditec.dpf.gov.br/download/sistemas/'
$filesRoot = @('ditec.crt', 'icpbrasilv2.cer')
$filesCA = @('acrfbv3.cer', 'acserprorfbv4.cer', 'acserprov3.cer', 'acserprofinalv4.cer')

$chocTempDir = $env:TEMP
$tempDir = Join-Path $chocTempDir "$packageName"
if ($env:packageVersion -ne $null) {$tempDir = Join-Path $tempDir "$env:packageVersion"; }

if (![System.IO.Directory]::Exists($tempDir)) {[System.IO.Directory]::CreateDirectory($tempDir) | Out-Null}

forEach ($file in $filesRoot){
  $filePath = Join-Path $tempDir $file
  $fileUrl = -join($baseUrl,$file)
  
  Get-ChocolateyWebFile $packageName $filePath $fileUrl 
  Start-ChocolateyProcessAsAdmin "-addstore Root $filePath" certutil
}

forEach ($file in $filesCA){
  $filePath = Join-Path $tempDir $file
  $fileUrl = -join($baseUrl,$file)
  
  Get-ChocolateyWebFile $packageName $filePath $fileUrl 
  Start-ChocolateyProcessAsAdmin "-addstore CA $filePath" certutil
}

