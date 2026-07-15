#!/bin/sh
# market 安装脚本(macOS Apple Silicon)。装到 ~/.local/bin,已存在则覆盖为最新。
set -eu

REPO="98DE9E1F/rise-market"
BIN_DIR="${MARKET_BIN:-$HOME/.local/bin}"

case "$(uname -s)-$(uname -m)" in
  Darwin-arm64) ASSET="market-darwin-arm64" ;;
  *) echo "暂只支持 macOS Apple Silicon(要 Windows 用 install.ps1)" >&2; exit 1 ;;
esac

URL=$(curl -fsSL "https://api.github.com/repos/$REPO/releases/latest" |
  grep -o "\"browser_download_url\": *\"[^\"]*$ASSET\"" | head -1 | cut -d'"' -f4)
[ -n "$URL" ] || { echo "找不到最新版的 $ASSET" >&2; exit 1; }

mkdir -p "$BIN_DIR"
echo "下载 $URL"
curl -fL -o "$BIN_DIR/market" "$URL"
chmod +x "$BIN_DIR/market"

echo "✓ market 已装到 $BIN_DIR/market"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "提示:$BIN_DIR 不在 PATH,加一行到 shell 配置:export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
"$BIN_DIR/market" status || true
