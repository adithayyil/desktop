# NixOS Build System 
# Run 'just' or 'just switch' to rebuild the system

# Default recipe - rebuild and switch
default: switch

# Rebuild and switch to new configuration
switch:
    sudo nixos-rebuild switch --flake . --impure

# Test configuration without switching boot default
test:
    sudo nixos-rebuild test --flake . --impure

# Build configuration without activating (check for errors)
check:
    nixos-rebuild dry-build --flake . --impure

# Update all flake inputs to latest versions
update:
    nix flake update

# Update and rebuild in one step
upgrade: update switch

# List all system generations
generations:
    nixos-rebuild list-generations

# Rollback to previous generation
rollback:
    sudo nixos-rebuild switch --rollback

# Clean up old generations (keeps last 7 days)
clean:
    sudo nix-collect-garbage --delete-older-than 7d

# Clean up everything except current generation
clean-all:
    sudo nix-collect-garbage -d

# Show what would be collected by garbage collector
gc-check:
    nix-store --gc --print-dead

# Optimize nix store (deduplicate files)
optimize:
    sudo nix-store --optimise

# Show flake info
info:
    nix flake show

# Check flake for issues
lint:
    nix flake check --impure
