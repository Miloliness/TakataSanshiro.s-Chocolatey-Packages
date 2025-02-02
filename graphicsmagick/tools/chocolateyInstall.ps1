$packageName    = 'graphicsmagick'
$url            = 'https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick-binaries/1.3.40/GraphicsMagick-1.3.40-Q8-win32-dll.exe'
$checksum       = '560BFCDEBD49E8594DC56CB5261EF4C95A8EE06E10D4D635944A2B391CE8D69B'
$checksumType   = 'sha256'
$url64          = 'https://sourceforge.net/projects/graphicsmagick/files/graphicsmagick-binaries/1.3.40/GraphicsMagick-1.3.40-Q8-win64-dll.exe'
$checksum64     = '8AF562FE1B6A80EC172D2D19707B99016D9195C37911371412667ACE3E3FB0E6'
$checksumType64 = 'sha256'
$installerType  = 'EXE'
$silentArgs     = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
$validExitCodes = @(0)

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -SilentArgs "$silentArgs" `
                          -Url "$url" `
                          -Url64 "$url64" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"
