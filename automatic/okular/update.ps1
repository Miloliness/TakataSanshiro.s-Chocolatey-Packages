import-module au

#$releases = 'https://github.com/KDE/okular/releases'
$artifacts64 = 'https://binary-factory.kde.org/view/Windows%2064-bit/job/Okular_Release_win64/lastSuccessfulBuild/artifact/'

function global:au_SearchReplace {
        @{
        "okular.nuspec" = @{
            #"(\<licenseUrl\>).*(\<\/licenseUrl\>)"     = "`${1}$($Latest.Copying)`$2"
            #"(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
            }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(x86_64:).*"     = "`${1} $($Latest.URL64)"
            "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
            #"(?i)(The included 'LICENSE.txt' file have been obtained from:).*" = "`${1} $($Latest.Copying)"
            }
        }
}

function global:au_GetLatest {  
    #$download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    #$url           = $download_page.links | ? href -match '.zip$' | select -First 1 -expand href
    $version = ((Invoke-WebRequest $artifacts64 -UseBasicParsing).links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 1
    $build64 = ((Invoke-WebRequest $artifacts64 -UseBasicParsing).links | ? href -match '.exe$' | select -First 1 -expand href) -split '-' | select -First 1 -Skip 2

    @{
        Version      = $version
        URL64        = "https://binary-factory.kde.org/job/Okular_Release_win64/lastStableBuild/artifact/okular-$version-$build64-windows-msvc2019_64-cl.exe"
        #Copying      = 'https://cgit.kde.org/okular.git/plain/COPYING.LIB?h=v' + $version
        #ReleaseNotes = 'https://www.kde.org/announcements/fulllog_applications.php?version=' + $version + '#okular'
    }
}

function global:au_BeforeUpdate {
        #Invoke-WebRequest -Uri $Latest.Copying -OutFile "legal\LICENSE.txt"
        Get-RemoteFiles -Purge -NoSuffix
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Not Found'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
