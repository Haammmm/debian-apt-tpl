# Debian APT Sources Configuration Template

Modern APT sources configuration files for Debian stable systems using the DEB822 format.

## 📋 Overview

This repository provides ready-to-use APT sources configuration files for Debian stable that include:
- **Tsinghua University Mirror** (China, fast access for CN users)
- **Official Debian Mirror** (Global, fallback source)
- Modern DEB822 format (supported by APT >= 1.1)

## 📦 What's Included

### `debian.sources`
Main APT sources configuration including:
- `stable` - Main Debian stable release
- `stable-updates` - Important updates for stable
- `stable-security` - Security updates for stable

All sources include: `main`, `contrib`, `non-free`, and `non-free-firmware` components.

### `debian-backports.sources`
Backports repository configuration:
- `stable-backports` - Newer package versions backported to stable

## 🚀 Installation

### Prerequisites
- Debian stable (bookworm/12 or newer)
- Root or sudo access
- APT version >= 1.1 (supports DEB822 format)

### Quick Install

1. **Backup existing configuration** (recommended):
   ```bash
   sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup
   ```

2. **Copy the configuration files**:
   ```bash
   # For main repositories
   sudo cp debian.sources /etc/apt/sources.list.d/

   # For backports (optional)
   sudo cp debian-backports.sources /etc/apt/sources.list.d/
   ```

3. **Optional: Disable old sources.list**:
   ```bash
   sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
   ```

4. **Update package lists**:
   ```bash
   sudo apt update
   ```

## 💡 Usage

### Regular Package Installation
```bash
sudo apt update
sudo apt install <package-name>
```

### Installing from Backports
To install a package from backports explicitly:
```bash
sudo apt install -t stable-backports <package-name>
```

### Verify Sources are Working
```bash
apt policy
```

## 🌍 Mirror Information

### Tsinghua University Mirror
- **Location**: China
- **URL**: https://mirrors.tuna.tsinghua.edu.cn/
- **Speed**: Excellent for users in China
- **Official site**: https://mirrors.tuna.tsinghua.edu.cn/help/debian/

### Official Debian Mirror
- **URL**: https://deb.debian.org/
- **Coverage**: Global CDN
- **Purpose**: Fallback and global access

## 🔑 Security

All sources are configured with:
- HTTPS transport for secure downloads
- Official Debian signing key: `/usr/share/keyrings/debian-archive-keyring.gpg`
- No additional keys needed (uses system keyring)

## ⚙️ Customization

### Changing Mirror Priority
The sources are listed in order. APT will try each mirror in sequence. To prefer official mirrors over Tsinghua, simply reorder the stanzas in the files.

### Removing Source Packages
If you don't need source packages (`deb-src`), you can:
1. Edit the files in `/etc/apt/sources.list.d/`
2. Change `Types: deb deb-src` to `Types: deb`
3. Run `sudo apt update`

### Disabling Backports
If you don't need backports:
```bash
sudo rm /etc/apt/sources.list.d/debian-backports.sources
sudo apt update
```

## 📝 File Format

These files use the modern **DEB822 format** (also called "sources.list.d format"), which is:
- More structured than traditional one-line format
- Easier to read and maintain
- Recommended for new configurations
- Supported by APT since version 1.1

### Example DEB822 Stanza
```
Types: deb deb-src
URIs: https://mirrors.tuna.tsinghua.edu.cn/debian/
Suites: stable
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
```

## 🔧 Troubleshooting

### Issue: "Failed to fetch" errors
**Solution**: The mirror might be temporarily unavailable. APT will automatically try the next mirror in the list.

### Issue: "The following signatures couldn't be verified"
**Solution**: Update the Debian archive keyring:
```bash
sudo apt update
sudo apt install debian-archive-keyring
```

### Issue: Slow downloads
**Solution**: 
- If in China, ensure Tsinghua mirror entries are listed first
- If outside China, consider removing or reordering Tsinghua entries
- Or choose a different local mirror

## 📚 References

- [Debian Sources List Format](https://wiki.debian.org/SourcesList)
- [DEB822 Format Specification](https://manpages.debian.org/testing/apt/sources.list.5.en.html)
- [Tsinghua Mirror Help](https://mirrors.tuna.tsinghua.edu.cn/help/debian/)

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Feel free to submit issues or pull requests if you have suggestions for improvements!

---

**Note**: This configuration is designed for Debian stable. If you're using testing or unstable, you'll need to modify the `Suites` fields accordingly.
