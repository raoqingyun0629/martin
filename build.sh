#!/bin/bash
set -e

# Ensure we are in the directory of the script
cd "$(dirname "$0")"

# Check if cargo is installed
if ! command -v cargo &> /dev/null; then
    echo "Cargo not found. Attempting to install Rust..."
    if command -v rustup &> /dev/null; then
        echo "Rustup found but cargo not in PATH. sourcing env..."
        source "$HOME/.cargo/env"
    else
        echo "Installing rustup..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
        source "$HOME/.cargo/env"
    fi
fi

# Verify cargo is now available
if ! command -v cargo &> /dev/null; then
    echo "Failed to install/find cargo. Please install Rust manually."
    exit 1
fi

echo "Building project..."
cargo build --release

echo "Build complete. Binary should be in target/release/martin"
