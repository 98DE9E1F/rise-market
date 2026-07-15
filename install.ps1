# market 安装脚本(Windows x64)。装到 %LOCALAPPDATA%\market 并加入用户 PATH。
# 用 releases/latest/download 直链,不走 GitHub API(免匿名限流)。
$ErrorActionPreference = "Stop"

$repo = "98DE9E1F/rise-market"
$dir = Join-Path $env:LOCALAPPDATA "market"
$exe = Join-Path $dir "market.exe"

New-Item -ItemType Directory -Force -Path $dir | Out-Null
Write-Host "下载 market(latest)…"
Invoke-WebRequest "https://github.com/$repo/releases/latest/download/market-windows-x64.exe" -OutFile $exe

$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($userPath -notlike "*$dir*") {
  [Environment]::SetEnvironmentVariable("Path", "$userPath;$dir", "User")
  Write-Host "已把 $dir 加入用户 PATH(新开终端生效)"
}

Write-Host "✓ market 已装到 $exe"
& $exe status
