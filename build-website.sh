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

# Handle optional arguments
case "$1" in
  deploy)
    echo "Running Ansible playbook..."
    cd ansible
    ansible-playbook -i inventory setup_server.yml
    cd ..
    ;;
  run)
    echo "Starting local server with miniservserve..."
    miniserve ./web --index index.html
    ;;
  *)
    echo "Build completed. No action taken. Use 'deploy' or 'run'."
    ;;
esac
