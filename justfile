# Rebuild both system and home
default: all

# Rebuild system only
switch:
    nh os switch

# Rebuild home only
home:
    nh home switch

# Rebuild both system and home
all: switch home

# Test without switching boot
test:
    sudo nixos-rebuild test --flake .

# Check for errors
check:
    nixos-rebuild dry-build --flake .

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
    nix flake check

# Build config for a host (no deploy)
build host="meth":
    nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel

# Deploy to a host
deploy host:
    deploy .#{{host}} --skip-checks

# SSH to a host
ssh host:
    ssh {{host}}

# Update and deploy to a host
deploy-upgrade host: update (deploy host)

# Clean generations on a host
clean-remote host:
    ssh {{host}} "sudo nix-collect-garbage --delete-older-than 7d"
