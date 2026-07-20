This is a NixOS system. When new packages need to be installed to complete a task, prefer to create a nix flake declaring a devshell for the required packages rther than attempting to install them system-wide.

You are in a sandboxed environment. You can write to the current working directory, /tmp, and some other necessary directories, but have readonly access to the rest of the file system. Some directories like ~/.ssh are hidden.

Always write shell scripts with `#!/usr/bin/env bash` instead of `#!/bin/bash` for compatibility.

To access the system clipboard use the command `wl-paste` and to modify the clipboard write to the stdin of `wl-copy`.
