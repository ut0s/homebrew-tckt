# tckt Homebrew distribution

This repository contains the Homebrew Formula and binary release assets for tckt.
The development repository and source code are not included.

Supported platforms: macOS 14 or later (Apple Silicon or Intel), and Linux x86_64 or ARM64.
No Rust, Node.js, or pnpm is needed on the installed machine.

```sh
brew install ut0s/tckt/tckt
cd /path/to/project
tckt init
tckt web
```

CLI: `tckt --help`; terminal UI: `tckt`; MCP: `tckt mcp --all-projects`.
For an optional login server, use `brew services start ut0s/tckt/tckt`.
On Linux, Homebrew service management requires systemd.
On macOS, stop a pre-existing `tckt service install` with `tckt service uninstall` first.
After upgrading, use `brew services restart ut0s/tckt/tckt`.
Projects, configuration, and task files are preserved on uninstall.

On macOS, tckt installs and uses PipoPapo 0.1.2 for audio notifications.

On Linux, install PipoPapo separately and make `pppp` available on the server's PATH for audio notifications.
