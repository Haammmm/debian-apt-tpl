#!/bin/bash
# Debian APT Sources Installation Script
# This script helps install the APT sources configuration files

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Error: This script must be run as root or with sudo${NC}"
    echo "Usage: sudo ./install.sh"
    exit 1
fi

echo "=========================================="
echo "Debian APT Sources Installation"
echo "=========================================="
echo

# Check if we're on Debian
if [ ! -f /etc/debian_version ]; then
    echo -e "${RED}Warning: This doesn't appear to be a Debian system${NC}"
    read -p "Continue anyway? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Backup existing sources.list
if [ -f /etc/apt/sources.list ]; then
    if [ ! -f /etc/apt/sources.list.backup ]; then
        echo -e "${YELLOW}Backing up /etc/apt/sources.list to /etc/apt/sources.list.backup${NC}"
        cp /etc/apt/sources.list /etc/apt/sources.list.backup
        echo -e "${GREEN}✓ Backup created${NC}"
    else
        echo -e "${YELLOW}Backup already exists at /etc/apt/sources.list.backup${NC}"
    fi
fi

# Install main sources
if [ -f debian.sources ]; then
    echo -e "${YELLOW}Installing debian.sources...${NC}"
    cp debian.sources /etc/apt/sources.list.d/
    echo -e "${GREEN}✓ debian.sources installed${NC}"
else
    echo -e "${RED}Error: debian.sources not found in current directory${NC}"
    exit 1
fi

# Ask about backports
echo
BACKPORTS_INSTALLED=false
read -p "Install backports configuration? (Y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    if [ -f debian-backports.sources ]; then
        echo -e "${YELLOW}Installing debian-backports.sources...${NC}"
        cp debian-backports.sources /etc/apt/sources.list.d/
        echo -e "${GREEN}✓ debian-backports.sources installed${NC}"
        BACKPORTS_INSTALLED=true
    else
        echo -e "${RED}Warning: debian-backports.sources not found${NC}"
    fi
fi

# Ask about disabling old sources.list
echo
read -p "Disable old /etc/apt/sources.list? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -f /etc/apt/sources.list ]; then
        mv /etc/apt/sources.list /etc/apt/sources.list.old
        echo -e "${GREEN}✓ Old sources.list moved to sources.list.old${NC}"
    fi
fi

# Update package lists
echo
echo -e "${YELLOW}Updating package lists...${NC}"
if apt update; then
    echo -e "${GREEN}✓ Package lists updated successfully${NC}"
    echo
    echo "=========================================="
    echo -e "${GREEN}Installation completed successfully!${NC}"
    echo "=========================================="
    echo
    echo "You can now install packages with:"
    echo "  sudo apt install <package-name>"
    if [ "$BACKPORTS_INSTALLED" = true ]; then
        echo
        echo "For backports packages:"
        echo "  sudo apt install -t stable-backports <package-name>"
    fi
else
    echo -e "${RED}Error: Failed to update package lists${NC}"
    echo "Please check your network connection and try again"
    exit 1
fi
