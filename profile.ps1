function Edit-Profile {vim $PROFILE.CurrentUserAllHosts}

if (!(Test-Path alias:git))
{
    New-Alias -Name git -Value "$Env:ProgramFiles\Git\bin\git.exe"
}
if (!(Test-Path alias:vim))
{
    New-Alias -Name vim -Value nvim
}
function CDDesktop {Set-Location 'C:\Users\msm11\OneDrive - NIST\Desktop'}
if (!(Test-Path alias:Desktop))
{
    New-Alias -Name Desktop -Value CDDesktop
}

function Prompt {
    Write-Host "$env:USERNAME" -ForegroundColor green -NoNewLine
    write-Host ":" -NoNewLine
    Write-Host "$(Split-Path -Path (Get-Location) -Leaf) " -ForegroundColor green -NoNewLine
    if(git rev-parse --is-inside-work-tree 2> $null)
    {
        $items = git status --porcelain | ForEach-Object {
            $first, $second = $_ -split "\s+", 2, "RegexMatch"; [tuple]::Create($first, $second)
        };
        $color = ""
        if ($items.Count -eq 0) { 
            $color = "green" 
        } 
        elseif ($items | Where-Object { $_.Item1 -ne "A" } | ForEach-Object {$true} | Select-Object -First 1) {
            $color = "red"
        }
        else {
            $color = "yellow"
        }
        Write-Host "$(git branch --show-current) " -ForegroundColor $color -NoNewLine
    }
    Write-Host ">" -NoNewLine
    return ' '
}

function Restore-DevDB
{
    $Path = Get-Location
    & D:\MEPDev\tfs.msm11\MEIS.NPR\DataBase\RestoreDevDB\RestoreLatest.ps1
    Set-location $Path
}