# Debian APT 软件源配置模板

适用于 Debian 稳定版系统的现代化 APT 软件源配置文件，使用 DEB822 格式。

## 📋 概述

本仓库提供即用型 APT 软件源配置文件，包含：
- **清华大学镜像源**（中国境内，访问速度快）
- **Debian 官方源**（全球内容分发网络，备用源）
- 现代 DEB822 格式（APT >= 1.1 支持）

## 📦 文件说明

### `debian.sources`
主要 APT 软件源配置，包括：
- `stable` - Debian 稳定版主仓库
- `stable-updates` - 稳定版重要更新
- `stable-security` - 稳定版安全更新
- `stable-backports` - 移植到稳定版的新版本软件包

所有源都包含：`main`、`contrib`、`non-free` 和 `non-free-firmware` 组件。

## 🚀 安装方法

### 系统要求
- Debian 稳定版（bookworm/12 或更新版本）
- Root 或 sudo 权限
- APT 版本 >= 1.1（支持 DEB822 格式）

### 快速安装

1. **备份现有配置**（建议）：
   ```bash
   sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
   ```

2. **复制配置文件**：
   ```bash
   sudo cp debian.sources /etc/apt/sources.list.d/
   ```

3. **可选：禁用旧的 sources.list**：
   ```bash
   sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
   ```

4. **更新软件包列表**：
   ```bash
   sudo apt update
   ```

## 💡 使用方法

### 常规软件包安装
```bash
sudo apt update
sudo apt install <软件包名>
```

### 从 Backports 安装软件
明确指定从 backports 安装软件包：
```bash
sudo apt install -t stable-backports <软件包名>
```

### 验证软件源是否正常工作
```bash
apt policy
```

## 🌍 镜像站信息

### 清华大学镜像站
- **位置**：中国
- **网址**：https://mirrors.tuna.tsinghua.edu.cn/
- **速度**：中国用户访问速度极佳
- **帮助页面**：https://mirrors.tuna.tsinghua.edu.cn/help/debian/

### Debian 官方镜像
- **网址**：https://deb.debian.org/
- **覆盖范围**：全球内容分发网络
- **用途**：备用源和全球访问

## 🔑 安全性

所有软件源配置为：
- HTTPS 传输协议，确保下载安全
- 使用 Debian 官方签名密钥：`/usr/share/keyrings/debian-archive-keyring.gpg`
- 无需额外添加密钥（使用系统自带密钥环）

## ⚙️ 自定义配置

### 更改镜像优先级
软件源按列出顺序使用。APT 会依次尝试每个镜像。若要优先使用官方源而非清华源，只需调整文件中各段落的顺序。

### 移除源码包
如果不需要源码包（`deb-src`），可以：
1. 编辑 `/etc/apt/sources.list.d/` 中的文件
2. 将 `Types: deb deb-src` 改为 `Types: deb`
3. 运行 `sudo apt update`

### 禁用 Backports
如果不需要 backports：
1. 编辑文件：`sudo nano /etc/apt/sources.list.d/debian.sources`
2. 从 `Suites` 行中移除 `stable-backports`
3. 运行 `sudo apt update`

## 📝 文件格式

这些文件使用现代化的 **DEB822 格式**（也称为 "sources.list.d 格式"）：
- 比传统单行格式更结构化
- 更易读和维护
- 推荐用于新配置
- APT 1.1 及以上版本支持

### DEB822 格式示例
```
Types: deb deb-src
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian/
Suites: stable
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

## 🔧 故障排除

### 问题："Failed to fetch" 错误
**解决方案**：镜像可能暂时不可用。APT 会自动尝试列表中的下一个镜像。

### 问题："The following signatures couldn't be verified"（无法验证签名）
**解决方案**：更新 Debian 归档密钥环：
```bash
sudo apt update
sudo apt install debian-archive-keyring
```

### 问题：下载速度慢
**解决方案**：
- 如果在中国境内，确保清华镜像条目在列表前面
- 如果在中国境外，考虑移除或重新排序清华镜像条目
- 或选择其他本地镜像站

## 📚 参考资料

- [Debian Sources List 格式](https://wiki.debian.org/SourcesList)
- [DEB822 格式规范](https://manpages.debian.org/testing/apt/sources.list.5.en.html)
- [清华镜像站帮助](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)

## 📄 许可证

MIT 许可证 - 详见 [LICENSE](LICENSE) 文件。

## 🤝 贡献

欢迎提交 Issue 或 Pull Request！

---

**注意**：本配置适用于 Debian 稳定版。如果您使用的是测试版或不稳定版，需要相应修改 `Suites` 字段。
