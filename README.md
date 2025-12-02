# desktop

My NixOS config with flakes + home-manager. 😋

## Structure

```
~/nix/                   
├── flake.nix            # flake with home-manager integration
├── configuration.nix    # main system config
├── justfile             # build/automations
├── modules/             # system-level modules
├── programs/            # system programs
├── pkgs/                # custom package overrides
└── home/                # home-manager (user-level)

/etc/nixos/                        # machine-specific
└── hardware-configuration.nix     # not in git
```

## Usage

```bash
# rebuild system
just

# test config without switching
just test

# update flake inputs
just update

# rollback if broken
just rollback

# clean old generations
just clean
```
