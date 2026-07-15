# market

Rise 产品的安装与更新入口。装好 `market` 之后,产品的安装/升级/登录都从它走。

## 安装

**macOS(Apple Silicon):**

```sh
curl -fsSL https://raw.githubusercontent.com/98DE9E1F/rise-market/main/install.sh | sh
```

**Windows(x64,PowerShell):**

```powershell
irm https://raw.githubusercontent.com/98DE9E1F/rise-market/main/install.ps1 | iex
```

## 用法

```
market list                 # 看货架
market install <产品>       # 安装(如 market install beat)
market upgrade              # 升级已装产品(顺带自升级)
market status               # 本机已装清单
market login [--github]     # 登录(GitHub 或邮箱验证码);私有产品需要
market whoami | logout
```

market 自身通过本仓库的 release 分发与自升级;产品的索引与下载走 market 服务端,一切下载均校验 sha256。

## 反馈

问题与建议请开 [issue](../../issues)。
