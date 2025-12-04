# Examples

This directory contains examples of how to use the APT sources configuration.

## Example 1: Basic Installation on Fresh Debian System

```bash
# Clone the repository
git clone https://github.com/Haammmm/debian-apt-tpl.git
cd debian-apt-tpl

# Use the automated installer
sudo ./install.sh
```

## Example 2: Manual Installation

```bash
# Download the files
wget https://raw.githubusercontent.com/Haammmm/debian-apt-tpl/main/debian.sources
wget https://raw.githubusercontent.com/Haammmm/debian-apt-tpl/main/debian-backports.sources

# Backup existing configuration
sudo cp /etc/apt/sources.list /etc/apt/sources.list.backup

# Install the configuration
sudo cp debian.sources /etc/apt/sources.list.d/
sudo cp debian-backports.sources /etc/apt/sources.list.d/

# Update
sudo apt update
```

## Example 3: Using Only Tsinghua Mirror (CN Users)

If you want to use only the Tsinghua mirror without fallback to official mirrors:

1. Edit the files and remove the official Debian mirror sections
2. Or create a custom version with only Tsinghua entries

## Example 4: Installing a Package from Backports

```bash
# First, ensure backports is configured
sudo apt update

# Install a specific package from backports
sudo apt install -t stable-backports neovim

# Check where a package would come from
apt policy firefox-esr
```

## Example 5: Verifying Sources are Working

```bash
# Check APT sources
apt policy

# Check a specific package
apt-cache policy firefox-esr

# Update and see which mirrors are being used
sudo apt update -v
```

## Example 6: For Users Outside China

If you're outside China and want better performance, edit the files to put official Debian mirrors first, or remove Tsinghua mirrors entirely:

```bash
# Edit the file
sudo nano /etc/apt/sources.list.d/debian.sources

# Reorder or remove Tsinghua sections, then update
sudo apt update
```
