# Instala todas las skills de skills.json (global)
$ErrorActionPreference = "Stop"
$url = "https://raw.githubusercontent.com/LordTobar/orlando-skills/main/skills.json"
$list = if (Test-Path "$PSScriptRoot\skills.json") { Get-Content "$PSScriptRoot\skills.json" -Raw | ConvertFrom-Json } else { Invoke-RestMethod $url }
foreach ($e in $list) {
  foreach ($s in $e.skills) {
    Write-Host ">> $($e.source) :: $s"
    npx skills@latest add $e.source --skill $s -g -y
  }
}
