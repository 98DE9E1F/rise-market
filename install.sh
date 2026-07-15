#!/bin/sh
# market 安装脚本(macOS Apple Silicon)。装到 ~/.local/bin,已存在则覆盖为最新。
# 用 releases/latest/download 直链,不走 GitHub API(免匿名限流)。
set -eu

REPO="98DE9E1F/rise-market"
BIN_DIR="${MARKET_BIN:-$HOME/.local/bin}"

case "$(uname -s)-$(uname -m)" in
  Darwin-arm64) ASSET="market-darwin-arm64" ;;
  *) echo "暂只支持 macOS Apple Silicon(要 Windows 用 install.ps1)" >&2; exit 1 ;;
esac

mkdir -p "$BIN_DIR"
echo "下载 market(latest)…"
curl -fL --retry 3 -o "$BIN_DIR/market" "https://github.com/$REPO/releases/latest/download/$ASSET"
chmod +x "$BIN_DIR/market"

echo "✓ market 已装到 $BIN_DIR/market"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "提示:$BIN_DIR 不在 PATH,加一行到 shell 配置:export PATH=\"$BIN_DIR:\$PATH\"" ;;
esac
"$BIN_DIR/market" status || true
