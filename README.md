# Univerasl Neovim configuration

> for nix,linux,windows,code...

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

## Installl

#### nix

```sh
nix run github:PostCyberpunk/nvim
nix run github:PostCyberpunk/nvim#full
```

### nixos-flake

Add to your flake input first

```nix
pcp-nvim.url = "github:PostCyberPunk/nvim?ref=dev";
```

> [!TIP]
> clone this repo to your XDG_CONFIG_HOME if you don't don't want to build every time when config changed..
>
> ```sh
> git clone https://github.com/postcyberpunk/nvim ~/.config/nvim
> ```

Import the nix module and setup your configuration

```nix
# add nixosModule to your imports
imports = [inputs.pcp-nvim.modules.default];
# config with:
programs.pcp-nvim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  # use the XDG_CONFIG_HOME/nvim ,so you won't have to build it.
  useXDG = true;
  # add plugins : "dap" "cpp" "rust" "unity" "java" "ai" "neorg" "extraTheme"
  extraPlugins = [];
};
```

#### windows

```sh
git clone https://github.com/postcyberpunk/nvim $env:LOCALAPPDATA\nvim
```

#### linux

```sh
git clone https://github.com/postcyberpunk/nvim ~/.config/nvim
```

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
