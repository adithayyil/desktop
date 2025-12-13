# Rebuild both system and home
default: all

# Rebuild system only
switch:
    nh os switch -- --impure

# Rebuild home only
home:
    nh home switch -- --impure

# Rebuild both system and home
all: switch home

# Test without switching boot
test:
    sudo nixos-rebuild test --flake . --impure

# Check for errors
check:
    nixos-rebuild dry-build --flake . --impure

# Update flake inputs
update:
    nix flake update

# Update flake and rebuild both
upgrade: update all

# List generations
generations:
    nixos-rebuild list-generations

# Rollback to previous
rollback:
    sudo nixos-rebuild switch --rollback

# Clean old generations (7 days)
clean:
    sudo nix-collect-garbage --delete-older-than 7d

# Clean everything
clean-all:
    sudo nix-collect-garbage -d

# Show what would be cleaned
gc-check:
    nix-store --gc --print-dead

# Optimize store
optimize:
    sudo nix-store --optimise

# Show flake info
info:
    nix flake show

# Check flake
lint:
    nix flake check --impure

# Build server config (no deploy)
build-server:
    nix build .#nixosConfigurations.server.config.system.build.toplevel --impure

# Deploy to server
deploy-server:
    deploy .#server --skip-checks

# SSH to server
ssh-server:
    ssh adi@server

# Update and deploy server
upgrade-server: update deploy-server

# Clean server generations
clean-server:
    ssh adi@server "sudo nix-collect-garbage --delete-older-than 7d"
