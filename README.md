# Installing

Sets up a gnome-based desktop with
- neovim with my vim config + nvim-treesitter
- intellij tied to 2022.2 to prevent annoying autoupgrades
- wayland + nvidia drivers
- rootless docker
- falcon sensor
- encrypted root with zfs
- no annoying extra gnome programs like gnome-weather

Before starting:

- https://nixos.wiki/wiki/Nvidia If you want to set up the nvidia nonfree drivers - read this, and edit the nvidia-offload.nix file
- You probably want to look through all the settings and change things, particularly the hostname, timezone, etc.

## Install

1. Boot nixos live installer and open a root terminal

1. `export EDITOR=vim` (replaces nano, useful for editing commands later on)

1. Open https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/Root%20on%20ZFS/1-preparation.html in browser

1. Copy paste all the instructions after setting the appropriate disk paths UNTIL setting the root password

   **NOTE**: If it tries to write anything into configuration.nix, change that to write into machine.nix

   Do not pass the 'mirror' options when creating the pools

   If this fails due to pool errors (eg, if you tried this before), do `zpool import -f <pool>` then `zpool destroy <pool>`

1. Put a '}' at the end of /mnt/etc/nixos/zfs.nix (normally put there by the instructions, but we skipped the last few steps)

1. Copy files from this repo into /mnt/etc/nixos

        rsync -av /path/to/repo/*.nix /mnt/etc/nixos/

1. Optional: If not using nvidia, you might want to disable wayland https://search.nixos.org/options?channel=22.11&show=services.xserver.displayManager.gdm.wayland&from=0&size=50&sort=relevance&type=packages&query=gdm

1. Run nixos install command as specified in the zfs installation instructions

   this might take ~20 minutes

1. Change password

        cd /mnt
        nixos-enter
        passwd michael

1. Exit chroot and run

        umount -Rl /mnt
        sync
        zpool export -a

## Post installation/reboot

### Keys

- Load in gpg keys 
- Load in ssh-keys
- ssh-add keys to gpg agent

### gvm

Install gvm from https://github.com/moovweb/gvm

```
nix-shell -p go
gvm install go1.18.3
```

### tree sitter

Open vim and run

```
:TSUpdate
```

### Enabling falcon

1. Move falcon deb to /opt/CrowdStrike (get from https://forgerock.slack.com/archives/CAVDE5K5M/p1660576127565849)

1. Edit configuration.nix to include falcon.nix

1. Set cid properly in falcon.nix

### TODO

Save falcon cid in nix store with https://github.com/Mic92/sops-nix or something like that

Add vscode + extension - nix-env-selector

Re-run tsupdate all the time in vim
