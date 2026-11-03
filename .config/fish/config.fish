if status is-interactive
# Commands to run in interactive sessions can go here
end

set fish_greeting ""

fish_add_path ~/.cargo/bin
set -U DOTS ~/dots

eval (starship init fish)

# aliases
alias buildpkg "cd (mktemp -d); nix-build '<nixpkgs>' --attr"
alias nixrb "sudo nixos-rebuild switch"
alias dl "trash -v"
alias cdtmp "cd (mktemp -d)"
alias tma "tmux new -As"