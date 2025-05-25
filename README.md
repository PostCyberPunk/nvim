```
▓█▄▄█▓▓█████████████████████▓▓▓██▓▄▄██▓█
███▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█▓█
███ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ █▓█
█▓█ ██▀▄ ▄▀██ ███▄▀▀▀▄▓▓██ ██▀▄ ▄▀▓▓ █▓█
███ █▌■   ■▐█ ██▓▓▌ ▐█████ █▌■   ■▐█ █▓█
█▓█ ▓▓▄▀ ▀▄██ █▓▓▀▄▄▄▀█▓▓█ ██▄▀ ▀▄██ █▓█
█▓█ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ███
█▓█             NEOVIM               █▓█
█▓█       Powered by Lazy.Nvim       ███
█████▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█████
█▓▓█▌ ▐█▀▀████████████████████▀▀█▌ ▐█▓▓█
████  ██▄▄████████████████▓▓██▄▄██  ████

   Spleen Artpack #03 ■ November 2011

 ▄█ ▄█  ▓▄   ▐█ ▓▌  █████  ▄█▓▓▄  █▄ █▄
▀▓▓▀██  ██▀  ▐█ █▌  █▓▓██  █████  ██▀▓▓▀
  ▀  ▀  ▀     ▀ ▀   ▀▀▀▀▀   ▀▀▀   ▀  ▀
```

# Neovim

## Back up

### windows

```sh
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.lazy
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.lazy
```

### linux

```sh
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

## Installl

### windows

```sh
git clone https://github.com/postcyberpunk/nvim $env:LOCALAPPDATA\nvim
```

### linux

```sh
git clone https://github.com/postcyberpunk/nvim ~/.config/nvim
cp ~/.config/nvim/lua/pcp/extra ~/.config/nvim/lua/pcp/extra.lua
```

<!-- TODO: use .git/info/exclude/ for extra.lua at somepoint -->
