# market 安装脚本(Windows x64)。装到 %LOCALAPPDATA%\market 并加入用户 PATH。
$ErrorActionPreference = "Stop"

$repo = "98DE9E1F/rise-market"
$dir = Join-Path $env:LOCALAPPDATA "market"
$exe = Join-Path $dir "market.exe"

$rel = Invoke-RestMethod "https://api.github.com/repos/$repo/releases/latest"
$asset = $rel.assets | Where-Object name -eq "market-windows-x64.exe"
if (-not $asset) { throw "找不到最新版的 market-windows-x64.exe" }

New-Item -ItemType Directory -Force -Path $dir | Out-Null
Write-Host "下载 $($asset.browser_download_url)"
Invoke-WebRequest $asset.browser_download_url -OutFile $exe

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$dir*") {
  [Environment]::SetEnvironmentVariable("Path", "$userPath;$dir", "User")
  Write-Host "已把 $dir 加入用户 PATH(新开终端生效)"
}

Write-Host "✓ market 已装到 $exe"
& $exe status
