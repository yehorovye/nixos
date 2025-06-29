###############################################################################
# 🛠️  NixOS & System Management Commands
#
# These commands help manage the system configuration using Nix flakes.
###############################################################################

# 🛑 Utility function: copy ~/nixos to /etc/nixos
copy-config:
  sudo cp -r ~/nixos/* /etc/nixos/

# 🚀 Deploy the current system configuration and make it the default on boot.
# Usage: just deploy
deploy:
  just copy-config
  sudo nixos-rebuild switch --flake /etc/nixos

# 🏡 Same as `deploy`, but with a custom flake target (e.g., for home-manager).
# Usage: just home
home:
  just copy-config
  sudo nixos-rebuild switch --flake /etc/nixos#nixos

# ⬆️ Upgrade system packages and apply the latest flake changes.
# Usage: just upgrade
upgrade:
  just copy-config
  sudo nixos-rebuild switch --upgrade --flake /etc/nixos

# 🐛 Like `deploy`, but with verbose logs and error traces for debugging.
# Usage: just debug
debug:
  just copy-config
  sudo nixos-rebuild switch --flake /etc/nixos --show-trace --verbose

# 🌐 Update all flake inputs to their latest versions.
# Usage: just up
up:
  nix flake update ~/nixos

# 🔍 Update a specific flake input (e.g., `i=home-manager`).
# Usage: just upp i=home-manager
upp:
  nix flake update ~/nixos/$(i)

# 🧪 Test the configuration without setting it as the default boot entry.
# Usage: just test
test:
  just copy-config
  sudo nixos-rebuild test --flake /etc/nixos

# 🕓 Show system profile history.
# Usage: just history
history:
  nix profile history --profile /nix/var/nix/profiles/system

# 💻 Launch the Nix REPL with nixpkgs from the flake.
# Usage: just repl
repl:
  nix repl -f flake:nixpkgs

# 🧹 Clean up system profile history older than 7 days.
# Usage: just clean
clean:
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 1d

# 🧼 Collect and delete old garbage as root.
# Usage: just gc-sudo
gc-sudo:
  sudo nix-collect-garbage -d

# 🧽 Same as above, but for the current user.
# Usage: just gc
gc:
  nix-collect-garbage -d

# 🥾 Boot into a specific configuration without switching immediately.
# Usage: just gcboot
gcboot:
  sudo /run/current-system/bin/switch-to-configuration boot

