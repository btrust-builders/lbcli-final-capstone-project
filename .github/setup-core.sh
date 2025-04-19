#!/bin/bash

# Exit on error, undefined variable usage, and prevent pipeline failures
set -euo pipefail

# Function to print messages
print_message() {
    echo -e "\n\033[1;34m$1\033[0m"  # Blue color for info
}

print_success() {
    echo -e "\n\033[1;32m✅ $1\033[0m"  # Green color for success
}

print_error() {
    echo -e "\n\033[1;31m❌ $1\033[0m"  # Red color for errors
    exit 1
}

# Update system
print_message "🔄 Updating system packages..."
sudo apt update && sudo apt upgrade -y || print_error "Failed to update system packages."

# Install dependencies
print_message "📦 Installing dependencies (wget, gpg, unzip)..."
sudo apt install -y wget gpg unzip || print_error "Failed to install dependencies."

# Set Bitcoin Core version
BITCOIN_VERSION="28.0"
BITCOIN_TAR="bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz"
BITCOIN_DIR="/opt/bitcoin-${BITCOIN_VERSION}"
BITCOIN_URL="https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/${BITCOIN_TAR}"

# Download Bitcoin Core
print_message "⬇️ Downloading Bitcoin Core v${BITCOIN_VERSION}..."
wget -q --show-progress "$BITCOIN_URL" || print_error "Failed to download Bitcoin Core."
wget -q https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS || print_error "Failed to download SHA256SUMS."
wget -q https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc || print_error "Failed to download SHA256SUMS.asc."
git clone https://github.com/bitcoin-core/guix.sigs.git || print_error "Failed to git clone guix.sigs"

print_message "🔍 Verifying download integrity..."

# Import Bitcoin Core signing keys
gpg --import guix.sigs/builder-keys/* || print_error "Failed to import GPG keys."

# Check file integrity
sha256sum --ignore-missing --check SHA256SUMS || print_error "Failed to check shasum"

# Verify signature
gpg --verify SHA256SUMS.asc || print_error "GPG signature verification failed."

# Extract Bitcoin Core
print_message "📂 Extracting Bitcoin Core..."
sudo tar -xzf "$BITCOIN_TAR" -C /opt || print_error "Failed to extract Bitcoin Core."

# Create Bitcoin directory
print_message "📁 Creating Bitcoin data directory..."
mkdir -p ~/.bitcoin || print_error "Failed to create Bitcoin data directory."

# Secure Bitcoin configuration
print_message "⚙️ Creating Bitcoin configuration file..."

cat << EOF > ~/.bitcoin/bitcoin.conf
signet=1
[signet]
server=1
txindex=1
debug=net
printtoconsole=1
rpcuser=btrustbuildersrpc
rpcpassword=btrustbuilderspass
rpcconnect=165.22.121.70
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0
fallbackfee=0.00001
EOF
chmod 600 ~/.bitcoin/bitcoin.conf  # Restrict permissions for security

# Add Bitcoin binaries to PATH
print_message "🛠️ Adding Bitcoin binaries to PATH..."
{
    echo "export PATH=\$PATH:${BITCOIN_DIR}/bin"
    echo "alias bitcoind='${BITCOIN_DIR}/bin/bitcoind'"
    echo "alias bitcoin-cli='${BITCOIN_DIR}/bin/bitcoin-cli'"
} >> ~/.bashrc

# Source updated profile safely
print_message "🔄 Reloading shell configuration..."
if source .bashrc; then
    print_success "PATH updated successfully."
else
    print_message "⚠️ Warning: Unable to reload shell. Restart your terminal for changes to take effect."
fi

# Clean up downloaded files
print_message "🧹 Cleaning up temporary files..."
rm -rf "$BITCOIN_TAR" SHA256SUMS SHA256SUMS.asc guix.sigs || print_error "Failed to clean up files."

# Check Bitcoin blockchain info status
print_message "🔍 Checking Bitcoin blockchain info status..."
bitcoin-cli getblockchaininfo || print_error "Failed to check Bitcoin blockchain info."

# Success message
print_success "🎉 Bitcoin Core installation complete and daemon started! Initial block download is in progress."
print_success "You can use the following commands:"
print_success "  - Start Bitcoin daemon: bitcoind -daemon"
print_success "  - Stop Bitcoin daemon: bitcoin-cli stop"
print_success "  - Check blockchain info: bitcoin-cli getblockchaininfo"
