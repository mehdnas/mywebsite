# My Website

A personal website built using a game engine (Bevy) to provide an interactive, game-like experience right in the browser. The game is compiled to WebAssembly (WASM) and served using a web server ([miniserve](https://github.com/svenstaro/miniserve) or [Apache2](https://httpd.apache.org/)).

## 🛠 Build & Deploy

### Build the Website

Run the build script to compile the Bevy game to WASM and generate the necessary JavaScript bindings using `wasm-bindgen`:

```
./build-website.sh
```

This outputs the game files into the `web/` directory.

### Serve Locally

To serve the website locally using [miniserve](https://github.com/svenstaro/miniserve):

```
./build-website.sh run
```

This will serve the contents of the `web/` directory at `http://localhost:8080`.

### Deploy to Server

To deploy the website to your server using Ansible (make sure your inventory file is configured):

```
./build-website.sh deploy
```

This will copy the site to your web server and configure Apache with HTTPS via Let's Encrypt.

## 📁 Project Structure

```
.
├── ansible                # Ansible playbook and inventory for deployment
│   ├── inventory
│   └── setup_server.yml
├── game                   # Bevy game source code
│   ├── Cargo.toml
│   └── src
├── web                    # Output directory for web files (index.html, game.js, etc.)
│   └── index.html
├── build-website.sh       # Build and deployment script
├── LICENSE
└── README.md
```

## 📦 Technologies Used

- [Bevy](https://bevyengine.org/) – Game engine rendered in the browser via WASM
- [wasm-bindgen](https://rustwasm.github.io/wasm-bindgen/)
- [miniserve](https://github.com/svenstaro/miniserve) – For local file serving
- [Ansible](https://www.ansible.com/) – Server provisioning and deployment
- [Apache2](https://httpd.apache.org/) – Web server
- [Let's Encrypt](https://letsencrypt.org/) – HTTPS certificate provisioning

---

> ⚠️ Requirements:
> - Rust toolchain with `wasm32-unknown-unknown` target
> - `wasm-bindgen-cli` installed
> - `miniserve` installed for local preview
