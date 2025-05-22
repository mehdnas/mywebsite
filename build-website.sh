#!/bin/bash
set -e  # Exit immediately if any command fails

echo "Building game..."
cd game
cargo build --release --target wasm32-unknown-unknown

echo "Copying .wasm to web directory..."
cp target/wasm32-unknown-unknown/release/game.wasm ../web/

echo "Running wasm-bindgen..."
cd ../web
wasm-bindgen --out-name game --out-dir . --target web game.wasm

cd ..

# Check if 'deploy' argument is passed
if [ "$1" == "deploy" ]; then
    echo "Running Ansible playbook..."
    cd ansible
    ansible-playbook -i inventory setup_server.yml
    cd ..
else
    echo "Build completed. Skipping deployment."
fi
